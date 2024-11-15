unit UDMSearchDF;

interface

uses
  System.SysUtils, System.Generics.Collections, FMX.Dialogs,
  System.TypInfo, System.NetEncoding, System.Math, System.IOUtils,

  UEntities, XData.Client, synautil, IniFiles, blcksock, Sparkle.Http.Client,
  ACBrDFe, ACBrNFe, ACBrBase, ACBrMail, ACBrDFeSSL, pcnConversao, pcnConversaoNFe, System.Classes;

type
  { Certificado }
  TCertificado = class
  private
    { private declarations }
  protected
    { protected declarations }
    FSSLLib     : integer;
    FCryptLib   : integer;
    FHttpLib    : integer;
    FXmlSignLib : integer;
    FDadosPFX   : AnsiString;
    FSenha      : string;
    FNumSerie   : string;
    FCaminho: string;

  public
    { public declarations }
    property SSLLib     : integer    read FSSLLib     write FSSLLib;
    property CryptLib   : integer    read FCryptLib   write FCryptLib;
    property HttpLib    : integer    read FHttpLib    write FHttpLib;
    property XmlSignLib : integer    read FXmlSignLib write FXmlSignLib;
    property DadosPFX   : AnsiString read FDadosPFX   write FDadosPFX;
    property Senha      : string     read FSenha      write FSenha;
    property NumSerie   : string     read FNumSerie   write FNumSerie;
    property Caminho    : string     read FCaminho    write FCaminho;

    Constructor Create;
    Destructor Destroy; override;
  end;

type
  { Geral }
  TGeral = class
  private
    { private declarations }
  protected
    { protected declarations }
    FAtualizarXML     : boolean;
    FExibirErroSchema : boolean;
    FFormatoAlerta    : string;
    FFormaEmissao     : integer;
    FVersaoDF         : integer;
    FSalvar           : boolean;
    FRetirarAcentos   :  boolean;
    FPathSalvar       : string;
    FPathSchemas      : string;
  public
    { public declarations }
    property AtualizarXML     : boolean read FAtualizarXML     write FAtualizarXML;
    property ExibirErroSchema : boolean read FExibirErroSchema write FExibirErroSchema;
    property FormatoAlerta    : string  read FFormatoAlerta    write FFormatoAlerta;
    property FormaEmissao     : integer read FFormaEmissao     write FFormaEmissao;
    property VersaoDF         : integer read FVersaoDF         write FVersaoDF;
    property Salvar           : boolean read FSalvar           write FSalvar ;
    property RetirarAcentos   : boolean read FRetirarAcentos   write FRetirarAcentos;
    property PathSalvar       : string  read FPathSalvar       write FPathSalvar;
    property PathSchemas      : string  read FPathSchemas      write FPathSchemas;

    Constructor Create;
    Destructor Destroy; override;
  end;

type
  { WebService }
  TWebService = class
  private
    { private declarations }
  protected
    { protected declarations }
    FUF : string;
    FAmbiente   : integer;
    FVisualizar : boolean;
    FSalvarSOAP : boolean;
    FAjustarAut : boolean;
    FAguardar   : integer;
    FTentativas : integer;
    FIntervalo  : integer;
    FTimeOut    : integer;
    FSSLType    : integer;
  public
    { public declarations }
    property UF         : string  read FUF         write FUF;
    property Ambiente   : integer read FAmbiente   write FAmbiente;
    property Visualizar : boolean read FVisualizar write FVisualizar;
    property SalvarSOAP : boolean read FSalvarSOAP write FSalvarSOAP;
    property AjustarAut : boolean read FAjustarAut write FAjustarAut;
    property Aguardar   : integer read FAguardar   write FAguardar;
    property Tentativas : integer read FTentativas write FTentativas;
    property Intervalo  : integer read FIntervalo  write FIntervalo;
    property TimeOut    : integer read FTimeOut    write FTimeOut;
    property SSLType    : integer read FSSLType    write FSSLType;

    Constructor Create;
    Destructor Destroy; override;
  end;

type
  { Proxy }
  TProxy = class
  private
    { private declarations }
  protected
    { protected declarations }
    FHost  : string;
    FPorta : integer;
    FUser  : string;
    FPass  : string;
  public
    { public declarations }
    property Host  : string  read FHost  write FHost;
    property Porta : integer read FPorta write FPorta;
    property User  : string  read FUser  write FUser;
    property Pass  : string  read FPass  write FPass;

    Constructor Create;
    Destructor Destroy; override;
  end;

type
  { Arquivos }
  TArquivos = class
  private
    { private declarations }
  protected
    { protected declarations }
    FSalvar           : boolean;
    FPastaMensal      : boolean;
    FAddLiteral       : boolean;
    FEmissaoPathMDFe  : boolean;
    FSalvarPathEvento : boolean;
    FSepararPorCNPJ   : boolean;
    FSepararPorModelo : boolean;
    FPathMDFe         : string;
    FPathEvento       : string;
  public
    { public declarations }
    property Salvar           : boolean read FSalvar           write FSalvar;
    property PastaMensal      : boolean read FPastaMensal      write FPastaMensal;
    property AddLiteral       : boolean read FAddLiteral       write FAddLiteral;
    property EmissaoPathMDFe  : boolean read FEmissaoPathMDFe  write FEmissaoPathMDFe;
    property SalvarPathEvento : boolean read FSalvarPathEvento write FSalvarPathEvento;
    property SepararPorCNPJ   : boolean read FSepararPorCNPJ   write FSepararPorCNPJ;
    property SepararPorModelo : boolean read FSepararPorModelo write FSepararPorModelo;
    property PathMDFe         : string  read FPathMDFe         write FPathMDFe;
    property PathEvento       : string  read FPathEvento       write FPathEvento;

    Constructor Create;
    Destructor Destroy; override;
  end;

type
  { Emitente }
  TEmitente = class
  private
    { private declarations }
  protected
    { protected declarations }
    FCNPJ        : string;
    FIE          : string;
    FRazaoSocial : string;
    FFantasia    : string;
    FFone        : string;
    FCEP         : string;
    FLogradouro  : string;
    FNumero      : string;
    FComplemento : string;
    FBairro      : string;
    FCodCidade   : string;
    FCidade      : string;
    FUF          : string;
  public
    { public declarations }
    property CNPJ        : string read FCNPJ        write FCNPJ;
    property IE          : string read FIE          write FIE;
    property RazaoSocial : string read FRazaoSocial write FRazaoSocial;
    property Fantasia    : string read FFantasia    write FFantasia;
    property Fone        : string read FFone        write FFone;
    property CEP         : string read FCEP         write FCEP;
    property Logradouro  : string read FLogradouro  write FLogradouro;
    property Numero      : string read FNumero      write FNumero;
    property Complemento : string read FComplemento write FComplemento;
    property Bairro      : string read FBairro      write FBairro;
    property CodCidade   : string read FCodCidade   write FCodCidade;
    property Cidade      : string read FCidade      write FCidade;
    property UF          : string read FUF          write FUF;

    Constructor Create;
    Destructor Destroy; override;
  end;

type
  { Email }
  TEmail = class
  private
    { private declarations }
  protected
    { protected declarations }
    FHost     : string;
    FPort     : integer;
    FUser     : string;
    FPass     : string;
    FAssunto  : string;
    FSSL      : boolean;
    FMensagem : TStream;
  public
    { public declarations }
    property Host     : string  read FHost     write FHost;
    property Port     : integer read FPort     write FPort;
    property User     : string  read FUser     write FUser;
    property Pass     : string  read FPass     write FPass;
    property Assunto  : string  read FAssunto  write FAssunto;
    property SSL      : boolean read FSSL      write FSSL;
    property Mensagem : TStream read FMensagem write FMensagem;

    Constructor Create;
    Destructor Destroy; override;
  end;

type
  { SearchDFe}
  TSearchDFe = class
  private
    { private declarations }
  protected
    { protected declarations }
    FCertificado : TCertificado;
    FGeral       : TGeral;
    FWebService  : TWebService;
    FProxy       : TProxy;
    FArquivos    : TArquivos;
    FEmitente    : TEmitente;
    FEmail       : TEmail;
  public
    { public declarations }
    property Certificado : TCertificado read FCertificado write FCertificado;
    property Geral       : TGeral       read FGeral       write FGeral;
    property WebService  : TWebService  read FWebService  write FWebService;
    property Proxy       : TProxy       read FProxy       write FProxy;
    property Arquivos    : TArquivos    read FArquivos    write FArquivos;
    property Emitente    : TEmitente    read FEmitente    write FEmitente;
    property Email       : TEmail       read FEmail       write FEmail;

    Constructor Create;
    Destructor Destroy; override;
  end;

type
  TdmSearchDFe = class(TDataModule)
    ACBrMail_ReadNFe: TACBrMail;
    ACBrNFe_ReadNFe: TACBrNFe;

    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LerConfiguracao(aToken : string; aidEmpresa : integer;
                              aEmpresa : Tempresa; aConfiguracao : Tconfiguracao);


    procedure GravarConfiguracao(aToken : string; aidEmpresa : integer;
                              aEmpresa : Tempresa; sPathCertificado : String);

    procedure ConfigurarComponente;
    procedure ConfigurarEmail;

    function ConsultaNF(var aReturn : TStringList; aEmpresa : TEmpresa; aNSU : string = '') : boolean;
  end;

var
  dmSearchDFe : TdmSearchDFe;
  searchDFe   : TSearchDFe;

implementation

uses
  ConnectionModule;

  {%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmSearchDFe.DataModuleDestroy(Sender: TObject);
begin
  searchDFe.DisposeOf;
end;

procedure TdmSearchDFe.DataModuleCreate(Sender: TObject);
begin
  searchDFe := TSearchDFe.Create;
end;

procedure TdmSearchDFe.ConfigurarComponente;
var
  Ok: Boolean;
  PathMensal: string;
begin
  ACBrNFe_ReadNFe.Configuracoes.Certificados.ArquivoPFX  := '';
  ACBrNFe_ReadNFe.Configuracoes.Certificados.URLPFX      := ''; {Essa URL tem que estar em branco por padrão}
  ACBrNFe_ReadNFe.Configuracoes.Certificados.Senha       := AnsiString(searchDFe.Certificado.Senha);
  ACBrNFe_ReadNFe.Configuracoes.Certificados.NumeroSerie := searchDFe.Certificado.NumSerie;
  ACBrNFe_ReadNFe.Configuracoes.Certificados.DadosPFX    := searchDFe.Certificado.DadosPFX;

  ACBrNFe_ReadNFe.SSL.DescarregarCertificado;

  with ACBrNFe_ReadNFe.Configuracoes.Geral do
  begin
    SSLLib        := TSSLLib(searchDFe.Certificado.SSLLib);
    SSLCryptLib   := TSSLCryptLib(searchDFe.Certificado.CryptLib);
    SSLHttpLib    := TSSLHttpLib(searchDFe.Certificado.HttpLib);
    SSLXmlSignLib := TSSLXmlSignLib(searchDFe.Certificado.XmlSignLib);

    // AtualizarSSLLibsCombo;

    Salvar           := searchDFe.Geral.Salvar;
    ExibirErroSchema := searchDFe.Geral.ExibirErroSchema;
    RetirarAcentos   := searchDFe.Geral.RetirarAcentos;
    FormatoAlerta    := searchDFe.Geral.FormatoAlerta;
    FormaEmissao     := TpcnTipoEmissao(searchDFe.Geral.FormaEmissao);
    VersaoDF         := TpcnVersaoDF(searchDFe.Geral.VersaoDF);
  end;

  with ACBrNFe_ReadNFe.Configuracoes.WebServices do
  begin
    UF         := searchDFe.WebService.UF;
    Ambiente   := StrToTpAmb(Ok, searchDFe.WebService.Ambiente.ToString);
    Visualizar := searchDFe.WebService.Visualizar;
    Salvar     := searchDFe.WebService.SalvarSOAP;

    AjustaAguardaConsultaRet := searchDFe.WebService.AjustarAut;

    try
      if (searchDFe.WebService.Aguardar = 0) then
        AguardarConsultaRet := ifThen(searchDFe.WebService.Aguardar < 1000, searchDFe.WebService.Aguardar * 1000, searchDFe.WebService.Aguardar)
      else
        searchDFe.WebService.Aguardar := AguardarConsultaRet;
    except
      searchDFe.WebService.Aguardar := 1000;
    end;

    try
      if (searchDFe.WebService.Tentativas = 0) then
        Tentativas := searchDFe.WebService.Tentativas
      else
         Tentativas := 2;
    except
      Tentativas := 2;
    end;

    try
      if (searchDFe.WebService.Intervalo = 0) then
        IntervaloTentativas := ifThen(searchDFe.WebService.Intervalo < 1000, (searchDFe.WebService.Intervalo * 1000), searchDFe.WebService.Intervalo)
      else
        searchDFe.WebService.Intervalo := ACBrNFe_ReadNFe.Configuracoes.WebServices.IntervaloTentativas;
    except
      IntervaloTentativas := 1000;
    end;

    TimeOut   := searchDFe.WebService.TimeOut;
    ProxyHost := searchDFe.Proxy.Host;
    ProxyPort := searchDFe.Proxy.Porta.ToString;
    ProxyUser := searchDFe.Proxy.User;
    ProxyPass := searchDFe.Proxy.Pass;
  end;

  ACBrNFe_ReadNFe.SSL.SSLType := TSSLType(searchDFe.WebService.SSLType);

  with ACBrNFe_ReadNFe.Configuracoes.Arquivos do
  begin
    Salvar           := searchDFe.Arquivos.Salvar;
    SepararPorMes    := searchDFe.Arquivos.PastaMensal;
    AdicionarLiteral := searchDFe.Arquivos.AddLiteral;
    //EmissaoPathMDFe  := cbxEmissaoPathMDFe.Checked;
    SepararPorCNPJ   := searchDFe.Arquivos.SepararPorCNPJ;
    SepararPorModelo := searchDFe.Arquivos.SepararPorModelo;
    PathSchemas      := searchDFe.Geral.PathSchemas;
    //PathMDFe         := edtPathSchemas.Text;
    PathEvento       := searchDFe.Arquivos.PathEvento;
    PathMensal       := searchDFe.Arquivos.PathEvento;
    PathSalvar       := searchDFe.Geral.PathSalvar;
  end;
end;

procedure TdmSearchDFe.LerConfiguracao(aToken : string; aidEmpresa : integer;
                                       aEmpresa : Tempresa; aConfiguracao : Tconfiguracao);
var
  //xConModule : TConnectionModulePG;
  ClientDoc : TXDataClient;
begin
  ClientDoc     := TXDataClient.Create;
  ClientDoc.Uri := URL_SERVER; //  'http://144.22.155.81/docfis/v1/xdata';

  // Passando o TOKEN
  ClientDoc.HttpClient.OnSendingRequest := procedure(Req: THttpRequest)
    begin
      Req.Headers.SetValue('Authorization', 'Bearer ' + aToken);
    end;

  //Configuracao := Tconfiguracao.Create;

  searchDFe.Certificado.SSLLib     := aConfiguracao.cfg_certificado_ssl_lib.ValueOrDefault;
  searchDFe.Certificado.CryptLib   := aConfiguracao.cfg_certificado_crypt_lib.ValueOrDefault;
  searchDFe.Certificado.HttpLib    := aConfiguracao.cfg_certificado_http_lib.ValueOrDefault;
  searchDFe.Certificado.XmlSignLib := aConfiguracao.cfg_certificado_xml_sign_lib.ValueOrDefault;

  searchDFe.Certificado.DadosPFX := aConfiguracao.cfg_certificado_dadospfx.AsString;

  searchDFe.Certificado.Senha    := aConfiguracao.cfg_certificado_senha.ValueOrDefault;
  searchDFe.Certificado.Caminho  := aConfiguracao.cfg_certificado_caminho.ValueOrDefault;
  searchDFe.Certificado.NumSerie := aConfiguracao.cfg_certificado_numserie.ValueOrDefault;

  searchDFe.Geral.AtualizarXML     := aConfiguracao.cfg_geral_atualizar_xml.ValueOrDefault;
  searchDFe.Geral.ExibirErroSchema := aConfiguracao.cfg_geral_exibir_erros_schema.ValueOrDefault;
  searchDFe.Geral.FormatoAlerta    := aConfiguracao.cfg_geral_formato_alerta.ValueOrDefault;  // Ini.ReadString('Geral', 'FormatoAlerta', 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.');
  searchDFe.Geral.FormaEmissao     := aConfiguracao.cfg_geral_forma_emissao.ValueOrDefault;
  searchDFe.Geral.VersaoDF         := aConfiguracao.cfg_geral_versao_df.ValueOrDefault;
  searchDFe.Geral.Salvar           := aConfiguracao.cfg_geral_salvar.ValueOrDefault;
  searchDFe.Geral.RetirarAcentos   := aConfiguracao.cfg_geral_retirar_acentos.ValueOrDefault;
  searchDFe.Geral.PathSalvar       := aConfiguracao.cfg_geral_path_salvar.ValueOrDefault;
  searchDFe.Geral.PathSchemas      := aConfiguracao.cfg_geral_path_schemas.ValueOrDefault;  // Ini.ReadString('Geral', 'PathSchemas', ExtractFilePath(ParamStr(0)) + 'Schemas\' + GetEnumName(TypeInfo(TpcnVersaoDF), integer(searchDFe.Geral.VersaoDF)));

  searchDFe.WebService.UF         := aConfiguracao.cfg_webservices_uf.ValueOrDefault;
  searchDFe.WebService.Ambiente   := aConfiguracao.cfg_webservices_ambiente.ValueOrDefault;
  searchDFe.WebService.Visualizar := aConfiguracao.cfg_webservices_visualizar.ValueOrDefault;

  searchDFe.WebService.SalvarSOAP := aConfiguracao.cfg_webservices_salvar_soap.ValueOrDefault;
  searchDFe.WebService.AjustarAut := aConfiguracao.cfg_webservices_ajustar_aut.ValueOrDefault;
  searchDFe.WebService.Aguardar   := aConfiguracao.cfg_webservices_aguardar.ValueOrDefault;
  searchDFe.WebService.Tentativas := aConfiguracao.cfg_webservices_tentativas.ValueOrDefault;
  searchDFe.WebService.Intervalo  := aConfiguracao.cfg_webservices_intervalo.ValueOrDefault;
  searchDFe.WebService.TimeOut    := aConfiguracao.cfg_webservices_timeout.ValueOrDefault;

  searchDFe.WebService.SSLType := aConfiguracao.cfg_webservices_ssl_type.ValueOrDefault;

  searchDFe.Proxy.Host  := aEmpresa.emp_email_host.ValueOrDefault;
  searchDFe.Proxy.Porta := aEmpresa.emp_email_port.ValueOrDefault;
  searchDFe.Proxy.User  := aEmpresa.emp_email_user.ValueOrDefault;
  searchDFe.Proxy.Pass  := aEmpresa.emp_email_pass.ValueOrDefault;

  searchDFe.Arquivos.Salvar           := aConfiguracao.cfg_arquivos_salvar.ValueOrDefault;
  searchDFe.Arquivos.PastaMensal      := aConfiguracao.cfg_arquivos_pasta_mensal.ValueOrDefault;
  searchDFe.Arquivos.AddLiteral       := aConfiguracao.cfg_arquivos_add_literal.ValueOrDefault;
  searchDFe.Arquivos.EmissaoPathMDFe  := aConfiguracao.cfg_arquivos_emissao_path_mdfe.ValueOrDefault;
  searchDFe.Arquivos.SalvarPathEvento := aConfiguracao.cfg_arquivos_salvar_path_evento.ValueOrDefault;
  searchDFe.Arquivos.SepararPorCNPJ   := aConfiguracao.cfg_arquivos_separar_por_cnpj.ValueOrDefault;
  searchDFe.Arquivos.SepararPorModelo := aConfiguracao.cfg_arquivos_separar_por_modelo.ValueOrDefault;
  searchDFe.Arquivos.PathMDFe         := aConfiguracao.cfg_arquivos_path_mdfe.ValueOrDefault;
  searchDFe.Arquivos.PathEvento       := aConfiguracao.cfg_arquivos_path_evento.ValueOrDefault;

  searchDFe.Emitente.CNPJ        := aEmpresa.emp_cnpj.ValueOrDefault;
  searchDFe.Emitente.IE          := aEmpresa.emp_ie.ValueOrDefault;
  searchDFe.Emitente.RazaoSocial := aEmpresa.emp_razao_social.ValueOrDefault;
  searchDFe.Emitente.Fantasia    := aEmpresa.emp_fantasia.ValueOrDefault;
  searchDFe.Emitente.Fone        := aEmpresa.emp_fone.ValueOrDefault;
  searchDFe.Emitente.CEP         := aEmpresa.emp_cep.ValueOrDefault;
  searchDFe.Emitente.Logradouro  := aEmpresa.emp_logradouro.ValueOrDefault;
  searchDFe.Emitente.Numero      := aEmpresa.emp_numero.ValueOrDefault;
  searchDFe.Emitente.Complemento := aEmpresa.emp_complemento.ValueOrDefault;
  searchDFe.Emitente.Bairro      := aEmpresa.emp_bairro.ValueOrDefault;
  searchDFe.Emitente.CodCidade   := aEmpresa.emp_cod_cidade.ValueOrDefault;
  searchDFe.Emitente.Cidade      := aEmpresa.emp_cidade.ValueOrDefault;
  searchDFe.Emitente.UF          := aEmpresa.emp_uf.ValueOrDefault;

  searchDFe.Email.Host    := aEmpresa.emp_email_host.ValueOrDefault;
  searchDFe.Email.Port    := aEmpresa.emp_email_port.ValueOrDefault;
  searchDFe.Email.User    := aEmpresa.emp_email_user.ValueOrDefault;
  searchDFe.Email.Pass    := aEmpresa.emp_email_pass.ValueOrDefault;
  searchDFe.Email.Assunto := aEmpresa.emp_email_assunto.ValueOrDefault;
  searchDFe.Email.SSL     := aEmpresa.emp_email_ssl.ValueOrDefault;

  ConfigurarComponente;
  ConfigurarEmail;
end;

procedure TdmSearchDFe.GravarConfiguracao(aToken : string; aidEmpresa : integer;
                                          aEmpresa : Tempresa; sPathCertificado : String);
var
  Configuracoes : TList<Tconfiguracao>;
  Configuracao  : Tconfiguracao;

  ClientDoc : TXDataClient;

begin
  ClientDoc     := TXDataClient.Create;
  ClientDoc.Uri := URL_SERVER;

  // Passando o TOKEN
  ClientDoc.HttpClient.OnSendingRequest := procedure(Req: THttpRequest)
    begin
      Req.Headers.SetValue('Authorization', 'Bearer ' + aToken);
    end;

  Configuracoes := TList<TConfiguracao>.Create;
  Configuracoes := ClientDoc.List<Tconfiguracao>('$expand=fk_emp&$filter=fk_emp/emp_id eq ' + aidEmpresa.ToString);

  if (Configuracoes.count > 1) then
  begin
    // ShowMessage('Mais de uma configuração localizada. Verifique seus dados ...');

    ClientDoc.DisposeOf;
    Configuracoes.DisposeOf;

    Exit;
  end;

  if (Configuracoes.count = 1) then
  begin
    Configuracao := ClientDoc.Get<TConfiguracao>(Configuracoes[0].cfg_id);
  end
    else
    begin
      Configuracao  := Tconfiguracao.Create;
    end;

  try
    Configuracao.fk_emp := aEmpresa;

    Configuracao.cfg_certificado_ssl_lib      := searchDFe.Certificado.SSLLib;
    Configuracao.cfg_certificado_crypt_lib    := searchDFe.Certificado.CryptLib;
    Configuracao.cfg_certificado_http_lib     := searchDFe.Certificado.HttpLib;
    Configuracao.cfg_certificado_xml_sign_lib := searchDFe.Certificado.XmlSignLib;

    // Grava certificado
    searchDFe.Certificado.DadosPFX := TFile.ReadAllText(sPathCertificado);

    try
      if not SameText(searchDFe.Certificado.DadosPFX, '') then
      begin
        Configuracao.cfg_certificado_dadospfx.AsBytes := TFile.ReadAllBytes(sPathCertificado);
        searchDFe.Certificado.NumSerie := dmSearchDFe.ACBrNFe_ReadNFe.SSL.SelecionarCertificado;
        Configuracao.cfg_certificado_numserie.Value := searchDFe.Certificado.NumSerie;
      end;
    except
    end;

    Configuracao.cfg_certificado_senha    := searchDFe.Certificado.Senha;
    Configuracao.cfg_certificado_caminho  := searchDFe.Certificado.Caminho;

    Configuracao.cfg_geral_exibir_erros_schema := searchDFe.Geral.ExibirErroSchema;
    Configuracao.cfg_geral_formato_alerta      := searchDFe.Geral.FormatoAlerta;
    Configuracao.cfg_geral_versao_df           := searchDFe.Geral.VersaoDF;
    Configuracao.cfg_geral_retirar_acentos     := searchDFe.Geral.RetirarAcentos;
    Configuracao.cfg_geral_salvar              := searchDFe.Geral.Salvar;
    Configuracao.cfg_geral_path_salvar         := searchDFe.Geral.PathSalvar;
    Configuracao.cfg_geral_path_schemas        := searchDFe.Geral.PathSchemas;

    Configuracao.cfg_webservices_ambiente    := searchDFe.WebService.Ambiente;
    Configuracao.cfg_webservices_visualizar  := searchDFe.WebService.Visualizar;
    Configuracao.cfg_webservices_salvar_soap := searchDFe.WebService.SalvarSOAP;
    Configuracao.cfg_webservices_ajustar_aut := searchDFe.WebService.AjustarAut;
    Configuracao.cfg_webservices_aguardar    := searchDFe.WebService.Aguardar;
    Configuracao.cfg_webservices_tentativas  := searchDFe.WebService.Tentativas;
    Configuracao.cfg_webservices_intervalo   := searchDFe.WebService.Intervalo;
    Configuracao.cfg_webservices_timeout     := searchDFe.WebService.TimeOut;
    Configuracao.cfg_webservices_ssl_type    := searchDFe.WebService.SSLType;

    Configuracao.cfg_proxy_host := searchDFe.Proxy.Host;
    Configuracao.cfg_proxy_port := searchDFe.Proxy.Porta;
    Configuracao.cfg_proxy_user := searchDFe.Proxy.User;
    Configuracao.cfg_proxy_pass := searchDFe.Proxy.Pass;

    Configuracao.cfg_arquivos_salvar             := searchDFe.Arquivos.Salvar;
    Configuracao.cfg_arquivos_pasta_mensal       := searchDFe.Arquivos.PastaMensal;
    Configuracao.cfg_arquivos_add_literal        := searchDFe.Arquivos.AddLiteral;
    Configuracao.cfg_arquivos_emissao_path_mdfe  := searchDFe.Arquivos.EmissaoPathMDFe;
    Configuracao.cfg_arquivos_salvar_path_evento := searchDFe.Arquivos.SalvarPathEvento;
    Configuracao.cfg_arquivos_separar_por_cnpj   := searchDFe.Arquivos.SepararPorCNPJ;
    Configuracao.cfg_arquivos_separar_por_modelo := searchDFe.Arquivos.SepararPorModelo;
    Configuracao.cfg_arquivos_path_mdfe          := searchDFe.Arquivos.PathMDFe;
    Configuracao.cfg_arquivos_salvar_path_evento := searchDFe.Arquivos.SalvarPathEvento;

    if (Configuracoes.count > 1) then
    begin
      ClientDoc.Post(Configuracao);
    end
      else
      begin
        ClientDoc.Put(Configuracao);
      end;

    ConfigurarComponente;
    ConfigurarEmail;
  finally
    Configuracoes.DisposeOf;
    Configuracao.DisposeOf;
    ClientDoc.DisposeOf;
  end;
end;

procedure TdmSearchDFe.ConfigurarEmail;
begin
  ACBrMail_ReadNFe.Host     := searchDFe.Email.Host;
  ACBrMail_ReadNFe.Port     := searchDFe.Email.Port.ToString;
  ACBrMail_ReadNFe.Username := searchDFe.Email.User;
  ACBrMail_ReadNFe.Password := searchDFe.Email.Pass;
  ACBrMail_ReadNFe.From     := searchDFe.Email.User;
  ACBrMail_ReadNFe.SetSSL   := searchDFe.Email.SSL;  // SSL - Conexao Segura
  ACBrMail_ReadNFe.SetTLS   := searchDFe.Email.SSL;  // Auto TLS

  ACBrMail_ReadNFe.ReadingConfirmation := False;       // Pede confirmacao de leitura do email
  ACBrMail_ReadNFe.UseThread           := False;       // Aguarda Envio do Email(nao usa thread)
  ACBrMail_ReadNFe.FromName            := ParamStr(0);
end;

function TdmSearchDFe.ConsultaNF(var aReturn : TStringList; aEmpresa : TEmpresa; aNSU : string = '') : boolean;
var
  xTitulo, cUFAutor, CNPJ, AultNSU: string;
  i: Integer;

  sSerie, sNumero, sCNPJ, sNome, sIEst, sNSU,
  sTipoNFe, sStatus, sChave, sDigVal, sNrProt,
  sArquivoXML, sAmbiente : String;

  dtDHRecbto, dtEmissao : TDateTime;

  Valor : Currency;

  j : integer;

  Consulta   : Tconsulta;
  Documento  : Tdocumento_fiscal;

  ClientDoc : TXDataClient;
begin
  xTitulo := 'Distribuição DF-e por último NSU';

  cUFAutor := ACBrNFe_ReadNFe.Configuracoes.WebServices.UFCodigo.ToString;
  CNPJ     := searchDFe.Emitente.CNPJ;
  AultNSU  := aNSU;

  var dhConsulta : TDateTime := now;

  try
    if SameStr(AultNSU, '') then
    begin
      ACBrNFe_ReadNFe.DistribuicaoDFe(ACBrNFe_ReadNFe.Configuracoes.WebServices.UFCodigo, searchDFe.Emitente.CNPJ, '0', '0');
    end
      else
      begin
        ACBrNFe_ReadNFe.DistribuicaoDFePorUltNSU(ACBrNFe_ReadNFe.Configuracoes.WebServices.UFCodigo, searchDFe.Emitente.CNPJ, AultNSU);
      end;
  except
    on e : exception do
    begin
      aReturn.Add(e.Message);
      Result := false;
      exit;
    end;
  end;

  with ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt do
  begin
    // Caso não retorne registros, ocorra consumo indevido ou seja o último lote, gera alerta
    if ( ( cStat = 137 ) or
         ( cStat = 656 ) or
         ( ultNSU = maxNSU ) ) then
    begin
      // 656-Consumo indevido
      if cStat = 656 then
      begin
        aReturn.Add('Atenção...: Consumo indevido.' + #13);

        if AultNSU <> ultNSU then
        begin
          aReturn.Add(' ultNSU utilizado nesta consulta [' + AultNSU + '] é diferente ');
          aReturn.Add('do ultNSU consultado na Sefaz [' + ultNSU + '].');
        end;
      end
        // 137-Nenhum documento localizado
        else if cStat = 137 then
          aReturn.Add('Atenção...: Não existem mais registros disponíveis.')

        // ultNSU = maxNSU - Documentos Localizados, mas é o último lote
        else
          aReturn.Add('Atenção...: Este é o último lote de registros disponíveis para distribuição.');

      aReturn.Add('Atenção...: Aguarde 1 hora para a próxima consulta.');
      aReturn.Add(' ');
    end;

    aReturn.Add('Qtde Documentos Retornados: ' + docZip.Count.ToString);
    aReturn.Add('Status....: ' + cStat.ToString);
    aReturn.Add('Motivo....: ' + xMotivo);
    aReturn.Add('Último NSU: ' + ultNSU);
    aReturn.Add('Máximo NSU: ' + maxNSU);
    aReturn.Add(' ');
    aReturn.Add('Documentos Retornados:');

    ClientDoc     := TXDataClient.Create;
    ClientDoc.Uri := URL_SERVER; // 'http://144.22.155.81/docfis/v1/xdata';

    // Grava o log de consultas
    Consulta := Tconsulta.Create;

    try
      Consulta.fk_emp := aEmpresa;

      case (searchDFe.WebService.Ambiente) of
        1 : sAmbiente := 'PRODUÇÃO';
        2 : sAmbiente := 'HOMOLOGAÇÃO';
      end;

      Consulta.cons_dh_consulta := dhConsulta;
      Consulta.cons_versao      := versao;
      Consulta.cons_tp_ambiente := sAmbiente;
      Consulta.cons_ver_aplic   := verAplic;
      Consulta.cons_status      := cStat;
      Consulta.cons_motivo      := docZip.Count.ToString + ' - ' + xMotivo;
      Consulta.cons_dh_resposta := now;
      // Consulta.cons_ind_cont
      Consulta.cons_ultimo_nsu  := ultNSU;
      Consulta.cons_maximo_nsu  := ultNSU;

      ClientDoc.Post(Consulta);
    finally
      Consulta.DisposeOf;
    end;

    for i := 0 to docZip.Count -1 do
    begin
      case docZip[i].schema of
        schresNFe:
          aReturn.Add((i+1).ToString + ' NSU: ' + docZip[i].NSU +
            ' (Resumo Nota) Chave: ' + docZip[i].resDFe.chDFe);

        schprocNFe:
          aReturn.Add((i+1).ToString + ' NSU: ' + docZip[i].NSU +
            ' (Nota Completa) Chave: ' + docZip[i].resDFe.chDFe);

        schresEvento:
          aReturn.Add((i+1).ToString + ' NSU: ' + docZip[i].NSU +
            ' (Resumo Evento) Chave: ' + docZip[i].resEvento.chDFe);

        schprocEventoNFe:
          aReturn.Add((i+1).ToString + ' NSU: ' + docZip[i].NSU +
            ' (Evento Completo) ID: ' + docZip[i].procEvento.Id);
      end;
    end;
  end;

  aReturn.Add(ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.RetWS);
  aReturn.Add(ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.RetornoWS);

  // Mostra os dados da(s) nota(s) recuperado(s)
  if ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 138 then
  begin
    j := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count - 1;

    for i := 0 to j do
    begin
      sSerie   := '';
      sNumero  := '';
      sCNPJ    := '';
      sNome    := '';
      sIEst    := '';
      sNSU     := '';
      sTipoNFe := '';
      sStatus  := ' ';

      sDigVal     := '';
      sNrProt     := '';
      sArquivoXML := '';

      if ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.chDFe <> '' then
      begin
        // Conjunto de informações resumo da NF-e localizadas.
        // Este conjunto de informação será gerado quando a NF-e for autorizada ou denegada.

        sChave := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.chDFe;

        sSerie  := Copy(sChave, 23, 3);
        sNumero := Copy(sChave, 26, 9);

        sCNPJ := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.CNPJCPF;
        sNome := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.xNome;
        sIEst := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.IE;

        case ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.tpNF of
          tnEntrada : sTipoNFe := 'ENTRADA';
          tnSaida   : sTipoNFe := 'SAÍDA';
        end;

        sNSU      := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].NSU;
        dtEmissao := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.dhEmi;
        Valor     := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.vNF;

        sDigVal     := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.digVal;
        dtDHRecbto  := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.dhRecbto;
        sNrProt     := ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.nProt;
        sArquivoXML := '';

        case ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.cSitDFe of
          snAutorizado : sStatus := 'AUTORIZADO';
          snDenegado   : sStatus := 'DENEGADO';
          snCancelado  : sStatus := 'CANCELADO';
        end;

        with aReturn do
        begin
          Add('');
          Add('------------- Dados da Nota Fiscal nr: ' + sNumero);
          Add('Chave: ' + sChave);

          Add('Série: ' + sSerie);
          Add('CNPJ: ' + sCNPJ);
          Add('Nome: ' + sNome);
          Add('IE: ' + sIEst);

          case ACBrNFe_ReadNFe.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[i].resDFe.tpNF of
            tnEntrada : Add('Tipo NFe: Entrada');
            tnSaida   : Add('Tipo NFe: Saída');
          end;

          Add('NSU: ' + sNSU);
          Add('Emissao: ' + DateToStr(dtEmissao));
          Add('Valor: ' + CurrToStrf(Valor, ffnumber, 2));

          Add('Status: ' + sStatus);
        end;

        Documento := Tdocumento_fiscal.Create;

        try
          Documento.fk_emp    := aEMPRESA;
          Documento.df_nsu    := sNSU;
          Documento.df_chave  := sChave;
          Documento.df_numero := sNumero;
          Documento.df_serie  := sSerie;
          Documento.df_cnpj   := sCNPJ;
          Documento.df_nome   := sNome;
          Documento.df_ie     := sIEst;

          try
            Documento.df_dt_emissao := dtEmissao;
            Documento.df_dh_recebto := dtDHRecbto;
          except
          end;

          Documento.df_tipo_nf   := sTipoNFe;
          Documento.df_valor     := Valor;
          Documento.df_status    := sStatus;
          Documento.df_protocolo := sNrProt;
          Documento.df_arquivo   := sArquivoXML;

          ClientDoc.Post(Documento);
        finally
          Documento.DisposeOf;
        end;
      end;
    end;
  end;

  ClientDoc.DisposeOf;
  result := True;
end;

{ TCertificado }
constructor TCertificado.Create;
begin
  //
end;

destructor TCertificado.Destroy;
begin

  inherited;
end;

{ TGeral }
constructor TGeral.Create;
begin
  //
end;

destructor TGeral.Destroy;
begin

  inherited;
end;

{ TWebService }
constructor TWebService.Create;
begin
  //
end;

destructor TWebService.Destroy;
begin

  inherited;
end;

{ TProxy }
constructor TProxy.Create;
begin
  //
end;

destructor TProxy.Destroy;
begin

  inherited;
end;

{ TArquivos }
constructor TArquivos.Create;
begin
  //
end;

destructor TArquivos.Destroy;
begin

  inherited;
end;

{ TEmitente }
constructor TEmitente.Create;
begin
  //
end;

destructor TEmitente.Destroy;
begin

  inherited;
end;

{ TEmail }
constructor TEmail.Create;
begin
  //
end;

destructor TEmail.Destroy;
begin

  inherited;
end;

// ---------------------------------------------------

{ TSearchDFe }
constructor TSearchDFe.Create;
begin
  // Constructor
  FCertificado := TCertificado.Create;
  FGeral       := TGeral.Create;
  FWebService  := TWebService.Create;
  FProxy       := TProxy.Create;
  FArquivos    := TArquivos.Create;
  FEmitente    := TEmitente.Create;
  FEmail       := TEmail.Create;
end;

destructor TSearchDFe.Destroy;
begin
  // Destructor
  FCertificado.DisposeOf;
  FGeral.DisposeOf;
  FWebService.DisposeOf;
  FProxy.DisposeOf;
  FArquivos.DisposeOf;
  FEmitente.DisposeOf;
  FEmail.DisposeOf;
end;

end.
