component output='false' accessors='true' hint='An extended query object with more props attached'{

    property name = 'sql'        type='String';
    property name = 'sqlType'    type='String'; // [DB2,MSSQL]
    property name = 'queryObj'   type='Query';
    property name = 'datasource' type='Struct';

    public any function init(required string sql, required string sqlType, required struct dataSource){
        this.setSql(arguments.sql);
        this.setSqlType(arguments.sqlType);
        this.setQueryObj(null);
        this.setDatasource(arguments.datasource);
        return this;
    }
}
