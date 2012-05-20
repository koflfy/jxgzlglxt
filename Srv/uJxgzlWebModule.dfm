object jxgzlWebModule: TjxgzlWebModule
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule3DefaultHandlerAction
    end>
  Height = 230
  Width = 415
  object HTTPSoapDispatcher1: THTTPSoapDispatcher
    Dispatcher = HTTPSoapPascalInvoker1
    WebDispatch.PathInfo = 'soap*'
    Left = 60
    Top = 11
  end
  object HTTPSoapPascalInvoker1: THTTPSoapPascalInvoker
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soUTF8InHeader, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 60
    Top = 67
  end
  object WSDLHTMLPublish1: TWSDLHTMLPublish
    WebDispatch.MethodType = mtAny
    WebDispatch.PathInfo = 'wsdl*'
    AdminEnabled = True
    TargetNamespace = 'http://tempuri.org/'
    Left = 60
    Top = 123
  end
end
