object dm: Tdm
  Height = 578
  Width = 605
  object XDataServer1: TXDataServer
    BaseUrl = 'http://+:2001/docfis/v1/xdata'
    Dispatcher = SparkleHttpSysDispatcher1
    Pool = XDataConnectionPool1
    DefaultEntitySetPermissions = [List, Get, Insert, Modify, Delete]
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerOptions.AuthMode = Jwt
    SwaggerUIOptions.Enabled = True
    SwaggerUIOptions.ShowFilter = True
    SwaggerUIOptions.DisplayOperationId = True
    OnEntityModified = XDataServer1EntityModified
    OnEntityGet = XDataServer1EntityGet
    OnEntityList = XDataServer1EntityList
    Left = 72
    Top = 40
    object XDataServer1CORS: TSparkleCorsMiddleware
      Origin = '*'
    end
    object XDataServer1JWT: TSparkleJwtMiddleware
      OnGetSecretEx = XDataServer1JWTGetSecretEx
      OnForbidRequest = XDataServer1JWTForbidRequest
    end
  end
  object SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher
    OnStart = SparkleHttpSysDispatcher1Start
    OnStop = SparkleHttpSysDispatcher1Stop
    Left = 216
    Top = 40
  end
  object AureliusConnection1: TAureliusConnection
    AdapterName = 'FireDac'
    AdaptedConnection = connection
    SQLDialect = 'PostgreSQL'
    Left = 72
    Top = 128
  end
  object connection: TFDConnection
    Params.Strings = (
      'Database=docdb'
      'User_Name=docuser'
      'Password=ReadDocFis#2023'
      'Server=168.138.141.12'
      'MetaDefSchema='
      'DriverID=PG')
    UpdateOptions.AssignedValues = [uvGeneratorName]
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 296
  end
  object XDataConnectionPool1: TXDataConnectionPool
    Connection = AureliusConnection1
    Left = 72
    Top = 200
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 272
    Top = 136
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 288
    Top = 224
  end
end
