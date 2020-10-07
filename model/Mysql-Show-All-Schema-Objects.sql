SELECT OBJECT_TYPE
	,OBJECT_SCHEMA
	,OBJECT_NAME
FROM (
	SELECT 'TABLE' AS OBJECT_TYPE
		,TABLE_NAME AS OBJECT_NAME
		,TABLE_SCHEMA AS OBJECT_SCHEMA
	FROM information_schema.TABLES
	
	UNION
	
	SELECT 'VIEW' AS OBJECT_TYPE
		,TABLE_NAME AS OBJECT_NAME
		,TABLE_SCHEMA AS OBJECT_SCHEMA
	FROM information_schema.VIEWS
	
	UNION
	
	SELECT 'INDEX[Type:Name:Table]' AS OBJECT_TYPE
		,CONCAT (
			CONSTRAINT_TYPE
			,' : '
			,CONSTRAINT_NAME
			,' : '
			,TABLE_NAME
			) AS OBJECT_NAME
		,TABLE_SCHEMA AS OBJECT_SCHEMA
	FROM information_schema.TABLE_CONSTRAINTS
	
	UNION
	
	SELECT ROUTINE_TYPE AS OBJECT_TYPE
		,ROUTINE_NAME AS OBJECT_NAME
		,ROUTINE_SCHEMA AS OBJECT_SCHEMA
	FROM information_schema.ROUTINES
	
	UNION
	
	SELECT 'TRIGGER[Schema:Object]' AS OBJECT_TYPE
		,CONCAT (
			TRIGGER_NAME
			,' : '
			,EVENT_OBJECT_SCHEMA
			,' : '
			,EVENT_OBJECT_TABLE
			) AS OBJECT_NAME
		,TRIGGER_SCHEMA AS OBJECT_SCHEMA
	FROM information_schema.triggers
	) R
WHERE R.OBJECT_SCHEMA = glue;