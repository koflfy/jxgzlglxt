object JxgzlSoapDM: TJxgzlSoapDM
  OldCreateOrder = False
  OnCreate = SoapDataModuleCreate
  OnDestroy = SoapDataModuleDestroy
  Height = 394
  Width = 561
  object AdoConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;User ID=sa;Initial Catalog=ZsbBM;Data Source=.;'
    ConnectionTimeout = 5
    KeepConnection = False
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 40
  end
  object DataSet_Query: TADODataSet
    Connection = AdoConnection1
    CursorType = ctStatic
    CommandText = 'select * from '#25805#20316#21592#34920
    Parameters = <>
    Left = 364
    Top = 40
  end
  object DataSet_Update: TADODataSet
    Connection = AdoConnection1
    Parameters = <>
    Left = 256
    Top = 40
  end
  object DSP_Query: TDataSetProvider
    DataSet = DataSet_Query
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 472
    Top = 176
  end
  object DSP_Update: TDataSetProvider
    DataSet = DataSet_Update
    Options = [poAllowMultiRecordUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 40
    Top = 244
  end
  object cds_Query: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP_Query'
    Left = 256
    Top = 176
  end
  object cds_Update: TClientDataSet
    Aggregates = <>
    PacketRecords = 0
    Params = <>
    ProviderName = 'DSP_Update'
    Left = 364
    Top = 176
  end
  object DataSet_Temp: TADODataSet
    Connection = AdoConnection1
    CursorType = ctStatic
    Parameters = <>
    Left = 148
    Top = 40
  end
  object sp_GetPayNo: TADOStoredProc
    Connection = AdoConnection1
    ProcedureName = 'up_GetPayNo;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@res_No'
        Attributes = [paNullable]
        DataType = ftWideString
        Direction = pdInputOutput
        Size = 19
        Value = Null
      end>
    Prepared = True
    Left = 40
    Top = 176
  end
  object sp_Temp: TADOStoredProc
    Connection = AdoConnection1
    Parameters = <>
    Prepared = True
    Left = 148
    Top = 176
  end
  object sp_GetRefundNo: TADOStoredProc
    Connection = AdoConnection1
    ProcedureName = 'up_GetRefundNo;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@res_No'
        Attributes = [paNullable]
        DataType = ftWideString
        Direction = pdInputOutput
        Size = 19
        Value = 'TF20091009000001'
      end>
    Prepared = True
    Left = 40
    Top = 108
  end
  object AdoQuery_Temp: TADOQuery
    Connection = AdoConnection1
    Parameters = <>
    Left = 472
    Top = 40
  end
  object sp_GetPayCheckNo: TADOStoredProc
    Connection = AdoConnection1
    ProcedureName = 'up_GetPayCheckNo;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@res_No'
        Attributes = [paNullable]
        DataType = ftWideString
        Direction = pdInputOutput
        Size = 19
        Value = 'JS200910110002'
      end>
    Prepared = True
    Left = 148
    Top = 108
  end
  object sp_ConfirmPayRecord: TADOStoredProc
    Connection = AdoConnection1
    ProcedureName = 'up_ConfirmPayRecord;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 1
      end
      item
        Name = '@Id'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 19
        Value = Null
      end
      item
        Name = '@PayStatus'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 10
        Value = Null
      end>
    Prepared = True
    Left = 472
    Top = 108
  end
  object sp_ExceptPayBackup: TADOStoredProc
    Connection = AdoConnection1
    ProcedureName = 'up_ExceptPayBackup;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 1
      end>
    Prepared = True
    Left = 364
    Top = 108
  end
  object sp_GetBmNo: TADOStoredProc
    Connection = AdoConnection1
    ProcedureName = 'up_GetBMNo;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@res_No'
        Attributes = [paNullable]
        DataType = ftWideString
        Direction = pdInputOutput
        Size = 19
        Value = 'BM20110010'
      end>
    Prepared = True
    Left = 256
    Top = 108
  end
  object VCLZip1: TVCLZip
    MultiZipInfo.BlockSize = 1457600
    Left = 256
    Top = 240
  end
  object sp_GetKsCj: TADOStoredProc
    Connection = AdoConnection1
    ProcedureName = 'up_GetKsCj;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@bkLb'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 10
        Value = Null
      end>
    Prepared = True
    Left = 42
    Top = 310
  end
  object DSP_GetKsCj: TDataSetProvider
    DataSet = sp_GetKsCj
    UpdateMode = upWhereKeyOnly
    Left = 146
    Top = 311
  end
  object cds_GetKsCj: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP_GetKsCj'
    Left = 252
    Top = 312
  end
end
