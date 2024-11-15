object ConnectionModulePG: TConnectionModulePG
  Height = 397
  Width = 634
  object fdDocFis_Conn: TFDConnection
    Params.Strings = (
      'Server=168.138.128.102'
      'Database=docfis'
      'User_Name=postgres'
      'Password=I9l7s5!#Y1973!#'
      'MetaDefSchema=docschema'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 128
    Top = 72
  end
  object auDocFis_Conn: TAureliusConnection
    AdapterName = 'FireDac'
    AdaptedConnection = fdDocFis_Conn
    SQLDialect = 'PostgreSQL'
    Left = 128
    Top = 184
  end
  object auManager: TAureliusManager
    Connection = auDocFis_Conn
    Left = 280
    Top = 184
  end
  object FDQuery1: TFDQuery
    Connection = fdDocFis_Conn
    Left = 360
    Top = 88
  end
end
