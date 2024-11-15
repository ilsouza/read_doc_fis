unit UEntities;

interface

uses
  SysUtils,
  Generics.Collections,
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties,
  Aurelius.Types.Nullable,
  Aurelius.Types.Proxy,
  Aurelius.Dictionary.Classes,
  Aurelius.Linq;

type
  Tconfiguracao = class;
  Tconsulta = class;
  Tdocumento_fiscal = class;
  Tempresa = class;
  Tfaturamento_detalhe = class;
  Tfaturamento_mestre = class;
  Ttoken = class;
  Tusuario = class;
  TconfiguracaoDictionary = class;
  TconsultaDictionary = class;
  Tdocumento_fiscalDictionary = class;
  TempresaDictionary = class;
  Tfaturamento_detalheDictionary = class;
  Tfaturamento_mestreDictionary = class;
  TtokenDictionary = class;
  TusuarioDictionary = class;

  [Entity]
  [Table('configuracao', 'docschema')]
  [Id('Fcfg_id', TIdGenerator.IdentityOrSequence)]
  Tconfiguracao = class
  private
    [Column('cfg_id', [TColumnProp.Required])]
    Fcfg_id: Integer;

    [Column('cfg_certificado_ssl_lib', [])]
    Fcfg_certificado_ssl_lib: Nullable<Integer>;

    [Column('cfg_certificado_crypt_lib', [])]
    Fcfg_certificado_crypt_lib: Nullable<Integer>;

    [Column('cfg_certificado_http_lib', [])]
    Fcfg_certificado_http_lib: Nullable<Integer>;

    [Column('cfg_certificado_xml_sign_lib', [])]
    Fcfg_certificado_xml_sign_lib: Nullable<Integer>;

    [Column('cfg_certificado_dadospfx', [TColumnProp.Lazy])]
    Fcfg_certificado_dadospfx: TBlob;

    [Column('cfg_certificado_senha', [], 30)]
    Fcfg_certificado_senha: Nullable<string>;

    [Column('cfg_certificado_caminho', [], 100)]
    Fcfg_certificado_caminho: Nullable<string>;

    [Column('cfg_certificado_numserie', [], 200)]
    Fcfg_certificado_numserie: Nullable<string>;

    [Column('cfg_geral_atualizar_xml', [])]
    Fcfg_geral_atualizar_xml: Nullable<Boolean>;

    [Column('cfg_geral_exibir_erros_schema', [])]
    Fcfg_geral_exibir_erros_schema: Nullable<Boolean>;

    [Column('cfg_geral_formato_alerta', [], 100)]
    Fcfg_geral_formato_alerta: Nullable<string>;

    [Column('cfg_geral_forma_emissao', [])]
    Fcfg_geral_forma_emissao: Nullable<Integer>;

    [Column('cfg_geral_versao_df', [])]
    Fcfg_geral_versao_df: Nullable<Integer>;

    [Column('cfg_geral_retirar_acentos', [])]
    Fcfg_geral_retirar_acentos: Nullable<Boolean>;

    [Column('cfg_geral_salvar', [])]
    Fcfg_geral_salvar: Nullable<Boolean>;

    [Column('cfg_geral_path_salvar', [], 100)]
    Fcfg_geral_path_salvar: Nullable<string>;

    [Column('cfg_geral_path_schemas', [], 100)]
    Fcfg_geral_path_schemas: Nullable<string>;

    [Column('cfg_webservices_uf', [], 2)]
    Fcfg_webservices_uf: Nullable<string>;

    [Column('cfg_webservices_ambiente', [])]
    Fcfg_webservices_ambiente: Nullable<Integer>;

    [Column('cfg_webservices_visualizar', [])]
    Fcfg_webservices_visualizar: Nullable<Boolean>;

    [Column('cfg_webservices_salvar_soap', [])]
    Fcfg_webservices_salvar_soap: Nullable<Boolean>;

    [Column('cfg_webservices_ajustar_aut', [])]
    Fcfg_webservices_ajustar_aut: Nullable<Boolean>;

    [Column('cfg_webservices_aguardar', [])]
    Fcfg_webservices_aguardar: Nullable<Integer>;

    [Column('cfg_webservices_tentativas', [])]
    Fcfg_webservices_tentativas: Nullable<Integer>;

    [Column('cfg_webservices_intervalo', [])]
    Fcfg_webservices_intervalo: Nullable<Integer>;

    [Column('cfg_webservices_timeout', [])]
    Fcfg_webservices_timeout: Nullable<Integer>;

    [Column('cfg_webservices_ssl_type', [])]
    Fcfg_webservices_ssl_type: Nullable<Integer>;

    [Column('cfg_proxy_host', [], 50)]
    Fcfg_proxy_host: Nullable<string>;

    [Column('cfg_proxy_port', [])]
    Fcfg_proxy_port: Nullable<Integer>;

    [Column('cfg_proxy_user', [], 20)]
    Fcfg_proxy_user: Nullable<string>;

    [Column('cfg_proxy_pass', [], 20)]
    Fcfg_proxy_pass: Nullable<string>;

    [Column('cfg_arquivos_salvar', [])]
    Fcfg_arquivos_salvar: Nullable<Boolean>;

    [Column('cfg_arquivos_pasta_mensal', [])]
    Fcfg_arquivos_pasta_mensal: Nullable<Boolean>;

    [Column('cfg_arquivos_add_literal', [])]
    Fcfg_arquivos_add_literal: Nullable<Boolean>;

    [Column('cfg_arquivos_emissao_path_mdfe', [])]
    Fcfg_arquivos_emissao_path_mdfe: Nullable<Boolean>;

    [Column('cfg_arquivos_salvar_path_evento', [])]
    Fcfg_arquivos_salvar_path_evento: Nullable<Boolean>;

    [Column('cfg_arquivos_separar_por_cnpj', [])]
    Fcfg_arquivos_separar_por_cnpj: Nullable<Boolean>;

    [Column('cfg_arquivos_separar_por_modelo', [])]
    Fcfg_arquivos_separar_por_modelo: Nullable<Boolean>;

    [Column('cfg_arquivos_path_mdfe', [], 100)]
    Fcfg_arquivos_path_mdfe: Nullable<string>;

    [Column('cfg_arquivos_path_evento', [], 100)]
    Fcfg_arquivos_path_evento: Nullable<string>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('fk_emp', [], 'emp_id')]
    Ffk_emp: Proxy<Tempresa>;
    function Getfk_emp: Tempresa;
    procedure Setfk_emp(const Value: Tempresa);
  public
    property cfg_id: Integer read Fcfg_id write Fcfg_id;
    property cfg_certificado_ssl_lib: Nullable<Integer> read Fcfg_certificado_ssl_lib write Fcfg_certificado_ssl_lib;
    property cfg_certificado_crypt_lib: Nullable<Integer> read Fcfg_certificado_crypt_lib write Fcfg_certificado_crypt_lib;
    property cfg_certificado_http_lib: Nullable<Integer> read Fcfg_certificado_http_lib write Fcfg_certificado_http_lib;
    property cfg_certificado_xml_sign_lib: Nullable<Integer> read Fcfg_certificado_xml_sign_lib write Fcfg_certificado_xml_sign_lib;
    property cfg_certificado_dadospfx: TBlob read Fcfg_certificado_dadospfx write Fcfg_certificado_dadospfx;
    property cfg_certificado_senha: Nullable<string> read Fcfg_certificado_senha write Fcfg_certificado_senha;
    property cfg_certificado_caminho: Nullable<string> read Fcfg_certificado_caminho write Fcfg_certificado_caminho;
    property cfg_certificado_numserie: Nullable<string> read Fcfg_certificado_numserie write Fcfg_certificado_numserie;
    property cfg_geral_atualizar_xml: Nullable<Boolean> read Fcfg_geral_atualizar_xml write Fcfg_geral_atualizar_xml;
    property cfg_geral_exibir_erros_schema: Nullable<Boolean> read Fcfg_geral_exibir_erros_schema write Fcfg_geral_exibir_erros_schema;
    property cfg_geral_formato_alerta: Nullable<string> read Fcfg_geral_formato_alerta write Fcfg_geral_formato_alerta;
    property cfg_geral_forma_emissao: Nullable<Integer> read Fcfg_geral_forma_emissao write Fcfg_geral_forma_emissao;
    property cfg_geral_versao_df: Nullable<Integer> read Fcfg_geral_versao_df write Fcfg_geral_versao_df;
    property cfg_geral_retirar_acentos: Nullable<Boolean> read Fcfg_geral_retirar_acentos write Fcfg_geral_retirar_acentos;
    property cfg_geral_salvar: Nullable<Boolean> read Fcfg_geral_salvar write Fcfg_geral_salvar;
    property cfg_geral_path_salvar: Nullable<string> read Fcfg_geral_path_salvar write Fcfg_geral_path_salvar;
    property cfg_geral_path_schemas: Nullable<string> read Fcfg_geral_path_schemas write Fcfg_geral_path_schemas;
    property cfg_webservices_uf: Nullable<string> read Fcfg_webservices_uf write Fcfg_webservices_uf;
    property cfg_webservices_ambiente: Nullable<Integer> read Fcfg_webservices_ambiente write Fcfg_webservices_ambiente;
    property cfg_webservices_visualizar: Nullable<Boolean> read Fcfg_webservices_visualizar write Fcfg_webservices_visualizar;
    property cfg_webservices_salvar_soap: Nullable<Boolean> read Fcfg_webservices_salvar_soap write Fcfg_webservices_salvar_soap;
    property cfg_webservices_ajustar_aut: Nullable<Boolean> read Fcfg_webservices_ajustar_aut write Fcfg_webservices_ajustar_aut;
    property cfg_webservices_aguardar: Nullable<Integer> read Fcfg_webservices_aguardar write Fcfg_webservices_aguardar;
    property cfg_webservices_tentativas: Nullable<Integer> read Fcfg_webservices_tentativas write Fcfg_webservices_tentativas;
    property cfg_webservices_intervalo: Nullable<Integer> read Fcfg_webservices_intervalo write Fcfg_webservices_intervalo;
    property cfg_webservices_timeout: Nullable<Integer> read Fcfg_webservices_timeout write Fcfg_webservices_timeout;
    property cfg_webservices_ssl_type: Nullable<Integer> read Fcfg_webservices_ssl_type write Fcfg_webservices_ssl_type;
    property cfg_proxy_host: Nullable<string> read Fcfg_proxy_host write Fcfg_proxy_host;
    property cfg_proxy_port: Nullable<Integer> read Fcfg_proxy_port write Fcfg_proxy_port;
    property cfg_proxy_user: Nullable<string> read Fcfg_proxy_user write Fcfg_proxy_user;
    property cfg_proxy_pass: Nullable<string> read Fcfg_proxy_pass write Fcfg_proxy_pass;
    property cfg_arquivos_salvar: Nullable<Boolean> read Fcfg_arquivos_salvar write Fcfg_arquivos_salvar;
    property cfg_arquivos_pasta_mensal: Nullable<Boolean> read Fcfg_arquivos_pasta_mensal write Fcfg_arquivos_pasta_mensal;
    property cfg_arquivos_add_literal: Nullable<Boolean> read Fcfg_arquivos_add_literal write Fcfg_arquivos_add_literal;
    property cfg_arquivos_emissao_path_mdfe: Nullable<Boolean> read Fcfg_arquivos_emissao_path_mdfe write Fcfg_arquivos_emissao_path_mdfe;
    property cfg_arquivos_salvar_path_evento: Nullable<Boolean> read Fcfg_arquivos_salvar_path_evento write Fcfg_arquivos_salvar_path_evento;
    property cfg_arquivos_separar_por_cnpj: Nullable<Boolean> read Fcfg_arquivos_separar_por_cnpj write Fcfg_arquivos_separar_por_cnpj;
    property cfg_arquivos_separar_por_modelo: Nullable<Boolean> read Fcfg_arquivos_separar_por_modelo write Fcfg_arquivos_separar_por_modelo;
    property cfg_arquivos_path_mdfe: Nullable<string> read Fcfg_arquivos_path_mdfe write Fcfg_arquivos_path_mdfe;
    property cfg_arquivos_path_evento: Nullable<string> read Fcfg_arquivos_path_evento write Fcfg_arquivos_path_evento;
    property fk_emp: Tempresa read Getfk_emp write Setfk_emp;
  end;

  [Entity]
  [Table('consulta', 'docschema')]
  [Id('Fcons_id', TIdGenerator.IdentityOrSequence)]
  Tconsulta = class
  private
    [Column('cons_id', [TColumnProp.Required])]
    Fcons_id: Integer;

    [Column('cons_dh_consulta', [])]
    Fcons_dh_consulta: Nullable<TDateTime>;

    [Column('cons_versao', [], 10)]
    Fcons_versao: Nullable<string>;

    [Column('cons_tp_ambiente', [], 15)]
    Fcons_tp_ambiente: Nullable<string>;

    [Column('cons_ver_aplic', [], 10)]
    Fcons_ver_aplic: Nullable<string>;

    [Column('cons_status', [])]
    Fcons_status: Nullable<Integer>;

    [Column('cons_motivo', [], 100)]
    Fcons_motivo: Nullable<string>;

    [Column('cons_dh_resposta', [])]
    Fcons_dh_resposta: Nullable<TDateTime>;

    [Column('cons_ind_cont', [])]
    Fcons_ind_cont: Nullable<Integer>;

    [Column('cons_ultimo_nsu', [], 20)]
    Fcons_ultimo_nsu: Nullable<string>;

    [Column('cons_maximo_nsu', [], 20)]
    Fcons_maximo_nsu: Nullable<string>;

    [Column('cons_arquivo', [], 100)]
    Fcons_arquivo: Nullable<string>;
  public
    property cons_id: Integer read Fcons_id write Fcons_id;
    property cons_dh_consulta: Nullable<TDateTime> read Fcons_dh_consulta write Fcons_dh_consulta;
    property cons_versao: Nullable<string> read Fcons_versao write Fcons_versao;
    property cons_tp_ambiente: Nullable<string> read Fcons_tp_ambiente write Fcons_tp_ambiente;
    property cons_ver_aplic: Nullable<string> read Fcons_ver_aplic write Fcons_ver_aplic;
    property cons_status: Nullable<Integer> read Fcons_status write Fcons_status;
    property cons_motivo: Nullable<string> read Fcons_motivo write Fcons_motivo;
    property cons_dh_resposta: Nullable<TDateTime> read Fcons_dh_resposta write Fcons_dh_resposta;
    property cons_ind_cont: Nullable<Integer> read Fcons_ind_cont write Fcons_ind_cont;
    property cons_ultimo_nsu: Nullable<string> read Fcons_ultimo_nsu write Fcons_ultimo_nsu;
    property cons_maximo_nsu: Nullable<string> read Fcons_maximo_nsu write Fcons_maximo_nsu;
    property cons_arquivo: Nullable<string> read Fcons_arquivo write Fcons_arquivo;
  end;

  [Entity]
  [Table('documento_fiscal', 'docschema')]
  [Id('Fdf_id', TIdGenerator.IdentityOrSequence)]
  Tdocumento_fiscal = class
  private
    [Column('df_id', [TColumnProp.Required])]
    Fdf_id: Integer;

    [Column('df_nsu', [], 20)]
    Fdf_nsu: Nullable<string>;

    [Column('df_chave', [], 44)]
    Fdf_chave: Nullable<string>;

    [Column('df_numero', [], 15)]
    Fdf_numero: Nullable<string>;

    [Column('df_serie', [], 10)]
    Fdf_serie: Nullable<string>;

    [Column('df_cnpj', [], 14)]
    Fdf_cnpj: Nullable<string>;

    [Column('df_nome', [], 50)]
    Fdf_nome: Nullable<string>;

    [Column('df_ie', [], 25)]
    Fdf_ie: Nullable<string>;

    [Column('df_dt_emissao', [])]
    Fdf_dt_emissao: Nullable<TDateTime>;

    [Column('df_tipo_nf', [], 15)]
    Fdf_tipo_nf: Nullable<string>;

    [Column('df_valor', [])]
    Fdf_valor: Nullable<Double>;

    [Column('df_status', [], 15)]
    Fdf_status: Nullable<string>;

    [Column('df_protocolo', [], 20)]
    Fdf_protocolo: Nullable<string>;

    [Column('df_arquivo', [], 100)]
    Fdf_arquivo: Nullable<string>;

    [Column('df_dh_recebto', [])]
    Fdf_dh_recebto: Nullable<TDateTime>;
  public
    property df_id: Integer read Fdf_id write Fdf_id;
    property df_nsu: Nullable<string> read Fdf_nsu write Fdf_nsu;
    property df_chave: Nullable<string> read Fdf_chave write Fdf_chave;
    property df_numero: Nullable<string> read Fdf_numero write Fdf_numero;
    property df_serie: Nullable<string> read Fdf_serie write Fdf_serie;
    property df_cnpj: Nullable<string> read Fdf_cnpj write Fdf_cnpj;
    property df_nome: Nullable<string> read Fdf_nome write Fdf_nome;
    property df_ie: Nullable<string> read Fdf_ie write Fdf_ie;
    property df_dt_emissao: Nullable<TDateTime> read Fdf_dt_emissao write Fdf_dt_emissao;
    property df_tipo_nf: Nullable<string> read Fdf_tipo_nf write Fdf_tipo_nf;
    property df_valor: Nullable<Double> read Fdf_valor write Fdf_valor;
    property df_status: Nullable<string> read Fdf_status write Fdf_status;
    property df_protocolo: Nullable<string> read Fdf_protocolo write Fdf_protocolo;
    property df_arquivo: Nullable<string> read Fdf_arquivo write Fdf_arquivo;
    property df_dh_recebto: Nullable<TDateTime> read Fdf_dh_recebto write Fdf_dh_recebto;
  end;

  [Entity]
  [Table('empresa', 'docschema')]
  [Id('Femp_id', TIdGenerator.IdentityOrSequence)]
  Tempresa = class
  private
    [Column('emp_id', [TColumnProp.Required])]
    Femp_id: Integer;

    [Column('emp_cnpj', [], 14)]
    Femp_cnpj: Nullable<string>;

    [Column('emp_ie', [], 25)]
    Femp_ie: Nullable<string>;

    [Column('emp_razao_social', [], 50)]
    Femp_razao_social: Nullable<string>;

    [Column('emp_fantasia', [], 50)]
    Femp_fantasia: Nullable<string>;

    [Column('emp_fone', [], 15)]
    Femp_fone: Nullable<string>;

    [Column('emp_cep', [], 8)]
    Femp_cep: Nullable<string>;

    [Column('emp_logradouro', [], 100)]
    Femp_logradouro: Nullable<string>;

    [Column('emp_numero', [], 10)]
    Femp_numero: Nullable<string>;

    [Column('emp_complemento', [], 15)]
    Femp_complemento: Nullable<string>;

    [Column('emp_bairro', [], 30)]
    Femp_bairro: Nullable<string>;

    [Column('emp_cod_cidade', [], 10)]
    Femp_cod_cidade: Nullable<string>;

    [Column('emp_cidade', [], 50)]
    Femp_cidade: Nullable<string>;

    [Column('emp_uf', [], 2)]
    Femp_uf: Nullable<string>;

    [Column('emp_email_host', [], 50)]
    Femp_email_host: Nullable<string>;

    [Column('emp_email_port', [])]
    Femp_email_port: Nullable<Integer>;

    [Column('emp_email_user', [], 50)]
    Femp_email_user: Nullable<string>;

    [Column('emp_email_pass', [], 50)]
    Femp_email_pass: Nullable<string>;

    [Column('emp_email_assunto', [], 100)]
    Femp_email_assunto: Nullable<string>;

    [Column('emp_email_ssl', [])]
    Femp_email_ssl: Nullable<Boolean>;

    [Column('emp_email_mensagem', [], 500)]
    Femp_email_mensagem: Nullable<string>;

    [Column('emp_damfe_tipo', [])]
    Femp_damfe_tipo: Nullable<Integer>;
  public
    property emp_id: Integer read Femp_id write Femp_id;
    property emp_cnpj: Nullable<string> read Femp_cnpj write Femp_cnpj;
    property emp_ie: Nullable<string> read Femp_ie write Femp_ie;
    property emp_razao_social: Nullable<string> read Femp_razao_social write Femp_razao_social;
    property emp_fantasia: Nullable<string> read Femp_fantasia write Femp_fantasia;
    property emp_fone: Nullable<string> read Femp_fone write Femp_fone;
    property emp_cep: Nullable<string> read Femp_cep write Femp_cep;
    property emp_logradouro: Nullable<string> read Femp_logradouro write Femp_logradouro;
    property emp_numero: Nullable<string> read Femp_numero write Femp_numero;
    property emp_complemento: Nullable<string> read Femp_complemento write Femp_complemento;
    property emp_bairro: Nullable<string> read Femp_bairro write Femp_bairro;
    property emp_cod_cidade: Nullable<string> read Femp_cod_cidade write Femp_cod_cidade;
    property emp_cidade: Nullable<string> read Femp_cidade write Femp_cidade;
    property emp_uf: Nullable<string> read Femp_uf write Femp_uf;
    property emp_email_host: Nullable<string> read Femp_email_host write Femp_email_host;
    property emp_email_port: Nullable<Integer> read Femp_email_port write Femp_email_port;
    property emp_email_user: Nullable<string> read Femp_email_user write Femp_email_user;
    property emp_email_pass: Nullable<string> read Femp_email_pass write Femp_email_pass;
    property emp_email_assunto: Nullable<string> read Femp_email_assunto write Femp_email_assunto;
    property emp_email_ssl: Nullable<Boolean> read Femp_email_ssl write Femp_email_ssl;
    property emp_email_mensagem: Nullable<string> read Femp_email_mensagem write Femp_email_mensagem;
    property emp_damfe_tipo: Nullable<Integer> read Femp_damfe_tipo write Femp_damfe_tipo;
  end;

  [Entity]
  [Table('faturamento_detalhe', 'docschema')]
  [Id('Ffatd_id', TIdGenerator.IdentityOrSequence)]
  Tfaturamento_detalhe = class
  private
    [Column('fatd_id', [TColumnProp.Required])]
    Ffatd_id: Integer;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('fk_doc', [], 'df_id')]
    Ffk_doc: Proxy<Tdocumento_fiscal>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('fk_fatm', [], 'fatm_id')]
    Ffk_fatm: Proxy<Tfaturamento_mestre>;
    function Getfk_doc: Tdocumento_fiscal;
    procedure Setfk_doc(const Value: Tdocumento_fiscal);
    function Getfk_fatm: Tfaturamento_mestre;
    procedure Setfk_fatm(const Value: Tfaturamento_mestre);
  public
    property fatd_id: Integer read Ffatd_id write Ffatd_id;
    property fk_doc: Tdocumento_fiscal read Getfk_doc write Setfk_doc;
    property fk_fatm: Tfaturamento_mestre read Getfk_fatm write Setfk_fatm;
  end;

  [Entity]
  [Table('faturamento_mestre', 'docschema')]
  [Id('Ffatm_id', TIdGenerator.IdentityOrSequence)]
  Tfaturamento_mestre = class
  private
    [Column('fatm_id', [TColumnProp.Required])]
    Ffatm_id: Integer;

    [Column('fatm_periodo_inicial', [])]
    Ffatm_periodo_inicial: Nullable<TDateTime>;

    [Column('fatm_periodo_final', [])]
    Ffatm_periodo_final: Nullable<TDateTime>;

    [Column('fatm_qtd_notas', [])]
    Ffatm_qtd_notas: Nullable<Integer>;

    [Column('fatm_valor_por_nota_lida', [TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    Ffatm_valor_por_nota_lida: Nullable<Variant>;

    [Column('fatm_total_notas', [])]
    Ffatm_total_notas: Nullable<Integer>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('fk_emp', [], 'emp_id')]
    Ffk_emp: Proxy<Tempresa>;
    function Getfk_emp: Tempresa;
    procedure Setfk_emp(const Value: Tempresa);
  public
    property fatm_id: Integer read Ffatm_id write Ffatm_id;
    property fatm_periodo_inicial: Nullable<TDateTime> read Ffatm_periodo_inicial write Ffatm_periodo_inicial;
    property fatm_periodo_final: Nullable<TDateTime> read Ffatm_periodo_final write Ffatm_periodo_final;
    property fatm_qtd_notas: Nullable<Integer> read Ffatm_qtd_notas write Ffatm_qtd_notas;
    property fatm_valor_por_nota_lida: Nullable<Variant> read Ffatm_valor_por_nota_lida;
    property fatm_total_notas: Nullable<Integer> read Ffatm_total_notas write Ffatm_total_notas;
    property fk_emp: Tempresa read Getfk_emp write Setfk_emp;
  end;

  [Entity]
  [Table('token', 'docschema')]
  [Id('Ftok_id', TIdGenerator.IdentityOrSequence)]
  Ttoken = class
  private
    [Column('tok_id', [TColumnProp.Required])]
    Ftok_id: Integer;

    [Column('tok_token', [], 1000)]
    Ftok_token: Nullable<string>;

    [Column('tok_duracao_seg', [])]
    Ftok_duracao_seg: Nullable<Integer>;

    [Column('tok_chave', [], 50)]
    Ftok_chave: Nullable<string>;

    [Column('tok_data_hora', [])]
    Ftok_data_hora: Nullable<TDateTime>;

    [Column('tok_password', [], 20)]
    Ftok_password: Nullable<string>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('fk_emp', [], 'emp_id')]
    Ffk_emp: Proxy<Tempresa>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('fk_usr', [], 'usr_id')]
    Ffk_usr: Proxy<Tusuario>;
    function Getfk_emp: Tempresa;
    procedure Setfk_emp(const Value: Tempresa);
    function Getfk_usr: Tusuario;
    procedure Setfk_usr(const Value: Tusuario);
  public
    property tok_id: Integer read Ftok_id write Ftok_id;
    property tok_token: Nullable<string> read Ftok_token write Ftok_token;
    property tok_duracao_seg: Nullable<Integer> read Ftok_duracao_seg write Ftok_duracao_seg;
    property tok_chave: Nullable<string> read Ftok_chave write Ftok_chave;
    property tok_data_hora: Nullable<TDateTime> read Ftok_data_hora write Ftok_data_hora;
    property tok_password: Nullable<string> read Ftok_password write Ftok_password;
    property fk_emp: Tempresa read Getfk_emp write Setfk_emp;
    property fk_usr: Tusuario read Getfk_usr write Setfk_usr;
  end;

  [Entity]
  [Table('usuario', 'docschema')]
  [Id('Fusr_id', TIdGenerator.IdentityOrSequence)]
  Tusuario = class
  private
    [Column('usr_id', [TColumnProp.Required])]
    Fusr_id: Integer;

    [Column('usr_name', [], 30)]
    Fusr_name: Nullable<string>;

    [Column('usr_password', [], 20)]
    Fusr_password: Nullable<string>;

    [Column('usr_email', [], 50)]
    Fusr_email: Nullable<string>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('fk_emp', [], 'emp_id')]
    Ffk_emp: Proxy<Tempresa>;
    function Getfk_emp: Tempresa;
    procedure Setfk_emp(const Value: Tempresa);
  public
    property usr_id: Integer read Fusr_id write Fusr_id;
    property usr_name: Nullable<string> read Fusr_name write Fusr_name;
    property usr_password: Nullable<string> read Fusr_password write Fusr_password;
    property usr_email: Nullable<string> read Fusr_email write Fusr_email;
    property fk_emp: Tempresa read Getfk_emp write Setfk_emp;
  end;

  IconfiguracaoDictionary = interface;

  IconsultaDictionary = interface;

  Idocumento_fiscalDictionary = interface;

  IempresaDictionary = interface;

  Ifaturamento_detalheDictionary = interface;

  Ifaturamento_mestreDictionary = interface;

  ItokenDictionary = interface;

  IusuarioDictionary = interface;

  IconfiguracaoDictionary = interface(IAureliusEntityDictionary)
    function cfg_id: TLinqProjection;
    function cfg_certificado_ssl_lib: TLinqProjection;
    function cfg_certificado_crypt_lib: TLinqProjection;
    function cfg_certificado_http_lib: TLinqProjection;
    function cfg_certificado_xml_sign_lib: TLinqProjection;
    function cfg_certificado_dadospfx: TLinqProjection;
    function cfg_certificado_senha: TLinqProjection;
    function cfg_certificado_caminho: TLinqProjection;
    function cfg_certificado_numserie: TLinqProjection;
    function cfg_geral_atualizar_xml: TLinqProjection;
    function cfg_geral_exibir_erros_schema: TLinqProjection;
    function cfg_geral_formato_alerta: TLinqProjection;
    function cfg_geral_forma_emissao: TLinqProjection;
    function cfg_geral_versao_df: TLinqProjection;
    function cfg_geral_retirar_acentos: TLinqProjection;
    function cfg_geral_salvar: TLinqProjection;
    function cfg_geral_path_salvar: TLinqProjection;
    function cfg_geral_path_schemas: TLinqProjection;
    function cfg_webservices_uf: TLinqProjection;
    function cfg_webservices_ambiente: TLinqProjection;
    function cfg_webservices_visualizar: TLinqProjection;
    function cfg_webservices_salvar_soap: TLinqProjection;
    function cfg_webservices_ajustar_aut: TLinqProjection;
    function cfg_webservices_aguardar: TLinqProjection;
    function cfg_webservices_tentativas: TLinqProjection;
    function cfg_webservices_intervalo: TLinqProjection;
    function cfg_webservices_timeout: TLinqProjection;
    function cfg_webservices_ssl_type: TLinqProjection;
    function cfg_proxy_host: TLinqProjection;
    function cfg_proxy_port: TLinqProjection;
    function cfg_proxy_user: TLinqProjection;
    function cfg_proxy_pass: TLinqProjection;
    function cfg_arquivos_salvar: TLinqProjection;
    function cfg_arquivos_pasta_mensal: TLinqProjection;
    function cfg_arquivos_add_literal: TLinqProjection;
    function cfg_arquivos_emissao_path_mdfe: TLinqProjection;
    function cfg_arquivos_salvar_path_evento: TLinqProjection;
    function cfg_arquivos_separar_por_cnpj: TLinqProjection;
    function cfg_arquivos_separar_por_modelo: TLinqProjection;
    function cfg_arquivos_path_mdfe: TLinqProjection;
    function cfg_arquivos_path_evento: TLinqProjection;
    function fk_emp: IempresaDictionary;
  end;

  IconsultaDictionary = interface(IAureliusEntityDictionary)
    function cons_id: TLinqProjection;
    function cons_dh_consulta: TLinqProjection;
    function cons_versao: TLinqProjection;
    function cons_tp_ambiente: TLinqProjection;
    function cons_ver_aplic: TLinqProjection;
    function cons_status: TLinqProjection;
    function cons_motivo: TLinqProjection;
    function cons_dh_resposta: TLinqProjection;
    function cons_ind_cont: TLinqProjection;
    function cons_ultimo_nsu: TLinqProjection;
    function cons_maximo_nsu: TLinqProjection;
    function cons_arquivo: TLinqProjection;
  end;

  Idocumento_fiscalDictionary = interface(IAureliusEntityDictionary)
    function df_id: TLinqProjection;
    function df_nsu: TLinqProjection;
    function df_chave: TLinqProjection;
    function df_numero: TLinqProjection;
    function df_serie: TLinqProjection;
    function df_cnpj: TLinqProjection;
    function df_nome: TLinqProjection;
    function df_ie: TLinqProjection;
    function df_dt_emissao: TLinqProjection;
    function df_tipo_nf: TLinqProjection;
    function df_valor: TLinqProjection;
    function df_status: TLinqProjection;
    function df_protocolo: TLinqProjection;
    function df_arquivo: TLinqProjection;
    function df_dh_recebto: TLinqProjection;
  end;

  IempresaDictionary = interface(IAureliusEntityDictionary)
    function emp_id: TLinqProjection;
    function emp_cnpj: TLinqProjection;
    function emp_ie: TLinqProjection;
    function emp_razao_social: TLinqProjection;
    function emp_fantasia: TLinqProjection;
    function emp_fone: TLinqProjection;
    function emp_cep: TLinqProjection;
    function emp_logradouro: TLinqProjection;
    function emp_numero: TLinqProjection;
    function emp_complemento: TLinqProjection;
    function emp_bairro: TLinqProjection;
    function emp_cod_cidade: TLinqProjection;
    function emp_cidade: TLinqProjection;
    function emp_uf: TLinqProjection;
    function emp_email_host: TLinqProjection;
    function emp_email_port: TLinqProjection;
    function emp_email_user: TLinqProjection;
    function emp_email_pass: TLinqProjection;
    function emp_email_assunto: TLinqProjection;
    function emp_email_ssl: TLinqProjection;
    function emp_email_mensagem: TLinqProjection;
    function emp_damfe_tipo: TLinqProjection;
  end;

  Ifaturamento_detalheDictionary = interface(IAureliusEntityDictionary)
    function fatd_id: TLinqProjection;
    function fk_doc: Idocumento_fiscalDictionary;
    function fk_fatm: Ifaturamento_mestreDictionary;
  end;

  Ifaturamento_mestreDictionary = interface(IAureliusEntityDictionary)
    function fatm_id: TLinqProjection;
    function fatm_periodo_inicial: TLinqProjection;
    function fatm_periodo_final: TLinqProjection;
    function fatm_qtd_notas: TLinqProjection;
    function fatm_valor_por_nota_lida: TLinqProjection;
    function fatm_total_notas: TLinqProjection;
    function fk_emp: IempresaDictionary;
  end;

  ItokenDictionary = interface(IAureliusEntityDictionary)
    function tok_id: TLinqProjection;
    function tok_token: TLinqProjection;
    function tok_duracao_seg: TLinqProjection;
    function tok_chave: TLinqProjection;
    function tok_data_hora: TLinqProjection;
    function tok_password: TLinqProjection;
    function fk_emp: IempresaDictionary;
    function fk_usr: IusuarioDictionary;
  end;

  IusuarioDictionary = interface(IAureliusEntityDictionary)
    function usr_id: TLinqProjection;
    function usr_name: TLinqProjection;
    function usr_password: TLinqProjection;
    function usr_email: TLinqProjection;
    function fk_emp: IempresaDictionary;
  end;

  TconfiguracaoDictionary = class(TAureliusEntityDictionary, IconfiguracaoDictionary)
  public
    function cfg_id: TLinqProjection;
    function cfg_certificado_ssl_lib: TLinqProjection;
    function cfg_certificado_crypt_lib: TLinqProjection;
    function cfg_certificado_http_lib: TLinqProjection;
    function cfg_certificado_xml_sign_lib: TLinqProjection;
    function cfg_certificado_dadospfx: TLinqProjection;
    function cfg_certificado_senha: TLinqProjection;
    function cfg_certificado_caminho: TLinqProjection;
    function cfg_certificado_numserie: TLinqProjection;
    function cfg_geral_atualizar_xml: TLinqProjection;
    function cfg_geral_exibir_erros_schema: TLinqProjection;
    function cfg_geral_formato_alerta: TLinqProjection;
    function cfg_geral_forma_emissao: TLinqProjection;
    function cfg_geral_versao_df: TLinqProjection;
    function cfg_geral_retirar_acentos: TLinqProjection;
    function cfg_geral_salvar: TLinqProjection;
    function cfg_geral_path_salvar: TLinqProjection;
    function cfg_geral_path_schemas: TLinqProjection;
    function cfg_webservices_uf: TLinqProjection;
    function cfg_webservices_ambiente: TLinqProjection;
    function cfg_webservices_visualizar: TLinqProjection;
    function cfg_webservices_salvar_soap: TLinqProjection;
    function cfg_webservices_ajustar_aut: TLinqProjection;
    function cfg_webservices_aguardar: TLinqProjection;
    function cfg_webservices_tentativas: TLinqProjection;
    function cfg_webservices_intervalo: TLinqProjection;
    function cfg_webservices_timeout: TLinqProjection;
    function cfg_webservices_ssl_type: TLinqProjection;
    function cfg_proxy_host: TLinqProjection;
    function cfg_proxy_port: TLinqProjection;
    function cfg_proxy_user: TLinqProjection;
    function cfg_proxy_pass: TLinqProjection;
    function cfg_arquivos_salvar: TLinqProjection;
    function cfg_arquivos_pasta_mensal: TLinqProjection;
    function cfg_arquivos_add_literal: TLinqProjection;
    function cfg_arquivos_emissao_path_mdfe: TLinqProjection;
    function cfg_arquivos_salvar_path_evento: TLinqProjection;
    function cfg_arquivos_separar_por_cnpj: TLinqProjection;
    function cfg_arquivos_separar_por_modelo: TLinqProjection;
    function cfg_arquivos_path_mdfe: TLinqProjection;
    function cfg_arquivos_path_evento: TLinqProjection;
    function fk_emp: IempresaDictionary;
  end;

  TconsultaDictionary = class(TAureliusEntityDictionary, IconsultaDictionary)
  public
    function cons_id: TLinqProjection;
    function cons_dh_consulta: TLinqProjection;
    function cons_versao: TLinqProjection;
    function cons_tp_ambiente: TLinqProjection;
    function cons_ver_aplic: TLinqProjection;
    function cons_status: TLinqProjection;
    function cons_motivo: TLinqProjection;
    function cons_dh_resposta: TLinqProjection;
    function cons_ind_cont: TLinqProjection;
    function cons_ultimo_nsu: TLinqProjection;
    function cons_maximo_nsu: TLinqProjection;
    function cons_arquivo: TLinqProjection;
  end;

  Tdocumento_fiscalDictionary = class(TAureliusEntityDictionary, Idocumento_fiscalDictionary)
  public
    function df_id: TLinqProjection;
    function df_nsu: TLinqProjection;
    function df_chave: TLinqProjection;
    function df_numero: TLinqProjection;
    function df_serie: TLinqProjection;
    function df_cnpj: TLinqProjection;
    function df_nome: TLinqProjection;
    function df_ie: TLinqProjection;
    function df_dt_emissao: TLinqProjection;
    function df_tipo_nf: TLinqProjection;
    function df_valor: TLinqProjection;
    function df_status: TLinqProjection;
    function df_protocolo: TLinqProjection;
    function df_arquivo: TLinqProjection;
    function df_dh_recebto: TLinqProjection;
  end;

  TempresaDictionary = class(TAureliusEntityDictionary, IempresaDictionary)
  public
    function emp_id: TLinqProjection;
    function emp_cnpj: TLinqProjection;
    function emp_ie: TLinqProjection;
    function emp_razao_social: TLinqProjection;
    function emp_fantasia: TLinqProjection;
    function emp_fone: TLinqProjection;
    function emp_cep: TLinqProjection;
    function emp_logradouro: TLinqProjection;
    function emp_numero: TLinqProjection;
    function emp_complemento: TLinqProjection;
    function emp_bairro: TLinqProjection;
    function emp_cod_cidade: TLinqProjection;
    function emp_cidade: TLinqProjection;
    function emp_uf: TLinqProjection;
    function emp_email_host: TLinqProjection;
    function emp_email_port: TLinqProjection;
    function emp_email_user: TLinqProjection;
    function emp_email_pass: TLinqProjection;
    function emp_email_assunto: TLinqProjection;
    function emp_email_ssl: TLinqProjection;
    function emp_email_mensagem: TLinqProjection;
    function emp_damfe_tipo: TLinqProjection;
  end;

  Tfaturamento_detalheDictionary = class(TAureliusEntityDictionary, Ifaturamento_detalheDictionary)
  public
    function fatd_id: TLinqProjection;
    function fk_doc: Idocumento_fiscalDictionary;
    function fk_fatm: Ifaturamento_mestreDictionary;
  end;

  Tfaturamento_mestreDictionary = class(TAureliusEntityDictionary, Ifaturamento_mestreDictionary)
  public
    function fatm_id: TLinqProjection;
    function fatm_periodo_inicial: TLinqProjection;
    function fatm_periodo_final: TLinqProjection;
    function fatm_qtd_notas: TLinqProjection;
    function fatm_valor_por_nota_lida: TLinqProjection;
    function fatm_total_notas: TLinqProjection;
    function fk_emp: IempresaDictionary;
  end;

  TtokenDictionary = class(TAureliusEntityDictionary, ItokenDictionary)
  public
    function tok_id: TLinqProjection;
    function tok_token: TLinqProjection;
    function tok_duracao_seg: TLinqProjection;
    function tok_chave: TLinqProjection;
    function tok_data_hora: TLinqProjection;
    function tok_password: TLinqProjection;
    function fk_emp: IempresaDictionary;
    function fk_usr: IusuarioDictionary;
  end;

  TusuarioDictionary = class(TAureliusEntityDictionary, IusuarioDictionary)
  public
    function usr_id: TLinqProjection;
    function usr_name: TLinqProjection;
    function usr_password: TLinqProjection;
    function usr_email: TLinqProjection;
    function fk_emp: IempresaDictionary;
  end;

  IDictionary = interface(IAureliusDictionary)
    function configuracao: IconfiguracaoDictionary;
    function consulta: IconsultaDictionary;
    function documento_fiscal: Idocumento_fiscalDictionary;
    function empresa: IempresaDictionary;
    function faturamento_detalhe: Ifaturamento_detalheDictionary;
    function faturamento_mestre: Ifaturamento_mestreDictionary;
    function token: ItokenDictionary;
    function usuario: IusuarioDictionary;
  end;

  TDictionary = class(TAureliusDictionary, IDictionary)
  public
    function configuracao: IconfiguracaoDictionary;
    function consulta: IconsultaDictionary;
    function documento_fiscal: Idocumento_fiscalDictionary;
    function empresa: IempresaDictionary;
    function faturamento_detalhe: Ifaturamento_detalheDictionary;
    function faturamento_mestre: Ifaturamento_mestreDictionary;
    function token: ItokenDictionary;
    function usuario: IusuarioDictionary;
  end;

function Dic: IDictionary;

implementation

var
  __Dic: IDictionary;

function Dic: IDictionary;
begin
  if __Dic = nil then __Dic := TDictionary.Create;
  result := __Dic;
end;

{ Tconfiguracao }

function Tconfiguracao.Getfk_emp: Tempresa;
begin
  result := Ffk_emp.Value;
end;

procedure Tconfiguracao.Setfk_emp(const Value: Tempresa);
begin
  Ffk_emp.Value := Value;
end;

{ Tfaturamento_detalhe }

function Tfaturamento_detalhe.Getfk_doc: Tdocumento_fiscal;
begin
  result := Ffk_doc.Value;
end;

procedure Tfaturamento_detalhe.Setfk_doc(const Value: Tdocumento_fiscal);
begin
  Ffk_doc.Value := Value;
end;

function Tfaturamento_detalhe.Getfk_fatm: Tfaturamento_mestre;
begin
  result := Ffk_fatm.Value;
end;

procedure Tfaturamento_detalhe.Setfk_fatm(const Value: Tfaturamento_mestre);
begin
  Ffk_fatm.Value := Value;
end;

{ Tfaturamento_mestre }

function Tfaturamento_mestre.Getfk_emp: Tempresa;
begin
  result := Ffk_emp.Value;
end;

procedure Tfaturamento_mestre.Setfk_emp(const Value: Tempresa);
begin
  Ffk_emp.Value := Value;
end;

{ Ttoken }

function Ttoken.Getfk_emp: Tempresa;
begin
  result := Ffk_emp.Value;
end;

procedure Ttoken.Setfk_emp(const Value: Tempresa);
begin
  Ffk_emp.Value := Value;
end;

function Ttoken.Getfk_usr: Tusuario;
begin
  result := Ffk_usr.Value;
end;

procedure Ttoken.Setfk_usr(const Value: Tusuario);
begin
  Ffk_usr.Value := Value;
end;

{ Tusuario }

function Tusuario.Getfk_emp: Tempresa;
begin
  result := Ffk_emp.Value;
end;

procedure Tusuario.Setfk_emp(const Value: Tempresa);
begin
  Ffk_emp.Value := Value;
end;

{ TconfiguracaoDictionary }

function TconfiguracaoDictionary.cfg_id: TLinqProjection;
begin
  Result := Prop('cfg_id');
end;

function TconfiguracaoDictionary.cfg_certificado_ssl_lib: TLinqProjection;
begin
  Result := Prop('cfg_certificado_ssl_lib');
end;

function TconfiguracaoDictionary.cfg_certificado_crypt_lib: TLinqProjection;
begin
  Result := Prop('cfg_certificado_crypt_lib');
end;

function TconfiguracaoDictionary.cfg_certificado_http_lib: TLinqProjection;
begin
  Result := Prop('cfg_certificado_http_lib');
end;

function TconfiguracaoDictionary.cfg_certificado_xml_sign_lib: TLinqProjection;
begin
  Result := Prop('cfg_certificado_xml_sign_lib');
end;

function TconfiguracaoDictionary.cfg_certificado_dadospfx: TLinqProjection;
begin
  Result := Prop('cfg_certificado_dadospfx');
end;

function TconfiguracaoDictionary.cfg_certificado_senha: TLinqProjection;
begin
  Result := Prop('cfg_certificado_senha');
end;

function TconfiguracaoDictionary.cfg_certificado_caminho: TLinqProjection;
begin
  Result := Prop('cfg_certificado_caminho');
end;

function TconfiguracaoDictionary.cfg_certificado_numserie: TLinqProjection;
begin
  Result := Prop('cfg_certificado_numserie');
end;

function TconfiguracaoDictionary.cfg_geral_atualizar_xml: TLinqProjection;
begin
  Result := Prop('cfg_geral_atualizar_xml');
end;

function TconfiguracaoDictionary.cfg_geral_exibir_erros_schema: TLinqProjection;
begin
  Result := Prop('cfg_geral_exibir_erros_schema');
end;

function TconfiguracaoDictionary.cfg_geral_formato_alerta: TLinqProjection;
begin
  Result := Prop('cfg_geral_formato_alerta');
end;

function TconfiguracaoDictionary.cfg_geral_forma_emissao: TLinqProjection;
begin
  Result := Prop('cfg_geral_forma_emissao');
end;

function TconfiguracaoDictionary.cfg_geral_versao_df: TLinqProjection;
begin
  Result := Prop('cfg_geral_versao_df');
end;

function TconfiguracaoDictionary.cfg_geral_retirar_acentos: TLinqProjection;
begin
  Result := Prop('cfg_geral_retirar_acentos');
end;

function TconfiguracaoDictionary.cfg_geral_salvar: TLinqProjection;
begin
  Result := Prop('cfg_geral_salvar');
end;

function TconfiguracaoDictionary.cfg_geral_path_salvar: TLinqProjection;
begin
  Result := Prop('cfg_geral_path_salvar');
end;

function TconfiguracaoDictionary.cfg_geral_path_schemas: TLinqProjection;
begin
  Result := Prop('cfg_geral_path_schemas');
end;

function TconfiguracaoDictionary.cfg_webservices_uf: TLinqProjection;
begin
  Result := Prop('cfg_webservices_uf');
end;

function TconfiguracaoDictionary.cfg_webservices_ambiente: TLinqProjection;
begin
  Result := Prop('cfg_webservices_ambiente');
end;

function TconfiguracaoDictionary.cfg_webservices_visualizar: TLinqProjection;
begin
  Result := Prop('cfg_webservices_visualizar');
end;

function TconfiguracaoDictionary.cfg_webservices_salvar_soap: TLinqProjection;
begin
  Result := Prop('cfg_webservices_salvar_soap');
end;

function TconfiguracaoDictionary.cfg_webservices_ajustar_aut: TLinqProjection;
begin
  Result := Prop('cfg_webservices_ajustar_aut');
end;

function TconfiguracaoDictionary.cfg_webservices_aguardar: TLinqProjection;
begin
  Result := Prop('cfg_webservices_aguardar');
end;

function TconfiguracaoDictionary.cfg_webservices_tentativas: TLinqProjection;
begin
  Result := Prop('cfg_webservices_tentativas');
end;

function TconfiguracaoDictionary.cfg_webservices_intervalo: TLinqProjection;
begin
  Result := Prop('cfg_webservices_intervalo');
end;

function TconfiguracaoDictionary.cfg_webservices_timeout: TLinqProjection;
begin
  Result := Prop('cfg_webservices_timeout');
end;

function TconfiguracaoDictionary.cfg_webservices_ssl_type: TLinqProjection;
begin
  Result := Prop('cfg_webservices_ssl_type');
end;

function TconfiguracaoDictionary.cfg_proxy_host: TLinqProjection;
begin
  Result := Prop('cfg_proxy_host');
end;

function TconfiguracaoDictionary.cfg_proxy_port: TLinqProjection;
begin
  Result := Prop('cfg_proxy_port');
end;

function TconfiguracaoDictionary.cfg_proxy_user: TLinqProjection;
begin
  Result := Prop('cfg_proxy_user');
end;

function TconfiguracaoDictionary.cfg_proxy_pass: TLinqProjection;
begin
  Result := Prop('cfg_proxy_pass');
end;

function TconfiguracaoDictionary.cfg_arquivos_salvar: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_salvar');
end;

function TconfiguracaoDictionary.cfg_arquivos_pasta_mensal: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_pasta_mensal');
end;

function TconfiguracaoDictionary.cfg_arquivos_add_literal: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_add_literal');
end;

function TconfiguracaoDictionary.cfg_arquivos_emissao_path_mdfe: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_emissao_path_mdfe');
end;

function TconfiguracaoDictionary.cfg_arquivos_salvar_path_evento: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_salvar_path_evento');
end;

function TconfiguracaoDictionary.cfg_arquivos_separar_por_cnpj: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_separar_por_cnpj');
end;

function TconfiguracaoDictionary.cfg_arquivos_separar_por_modelo: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_separar_por_modelo');
end;

function TconfiguracaoDictionary.cfg_arquivos_path_mdfe: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_path_mdfe');
end;

function TconfiguracaoDictionary.cfg_arquivos_path_evento: TLinqProjection;
begin
  Result := Prop('cfg_arquivos_path_evento');
end;

function TconfiguracaoDictionary.fk_emp: IempresaDictionary;
begin
  Result := TempresaDictionary.Create(PropName('fk_emp'));
end;

{ TconsultaDictionary }

function TconsultaDictionary.cons_id: TLinqProjection;
begin
  Result := Prop('cons_id');
end;

function TconsultaDictionary.cons_dh_consulta: TLinqProjection;
begin
  Result := Prop('cons_dh_consulta');
end;

function TconsultaDictionary.cons_versao: TLinqProjection;
begin
  Result := Prop('cons_versao');
end;

function TconsultaDictionary.cons_tp_ambiente: TLinqProjection;
begin
  Result := Prop('cons_tp_ambiente');
end;

function TconsultaDictionary.cons_ver_aplic: TLinqProjection;
begin
  Result := Prop('cons_ver_aplic');
end;

function TconsultaDictionary.cons_status: TLinqProjection;
begin
  Result := Prop('cons_status');
end;

function TconsultaDictionary.cons_motivo: TLinqProjection;
begin
  Result := Prop('cons_motivo');
end;

function TconsultaDictionary.cons_dh_resposta: TLinqProjection;
begin
  Result := Prop('cons_dh_resposta');
end;

function TconsultaDictionary.cons_ind_cont: TLinqProjection;
begin
  Result := Prop('cons_ind_cont');
end;

function TconsultaDictionary.cons_ultimo_nsu: TLinqProjection;
begin
  Result := Prop('cons_ultimo_nsu');
end;

function TconsultaDictionary.cons_maximo_nsu: TLinqProjection;
begin
  Result := Prop('cons_maximo_nsu');
end;

function TconsultaDictionary.cons_arquivo: TLinqProjection;
begin
  Result := Prop('cons_arquivo');
end;

{ Tdocumento_fiscalDictionary }

function Tdocumento_fiscalDictionary.df_id: TLinqProjection;
begin
  Result := Prop('df_id');
end;

function Tdocumento_fiscalDictionary.df_nsu: TLinqProjection;
begin
  Result := Prop('df_nsu');
end;

function Tdocumento_fiscalDictionary.df_chave: TLinqProjection;
begin
  Result := Prop('df_chave');
end;

function Tdocumento_fiscalDictionary.df_numero: TLinqProjection;
begin
  Result := Prop('df_numero');
end;

function Tdocumento_fiscalDictionary.df_serie: TLinqProjection;
begin
  Result := Prop('df_serie');
end;

function Tdocumento_fiscalDictionary.df_cnpj: TLinqProjection;
begin
  Result := Prop('df_cnpj');
end;

function Tdocumento_fiscalDictionary.df_nome: TLinqProjection;
begin
  Result := Prop('df_nome');
end;

function Tdocumento_fiscalDictionary.df_ie: TLinqProjection;
begin
  Result := Prop('df_ie');
end;

function Tdocumento_fiscalDictionary.df_dt_emissao: TLinqProjection;
begin
  Result := Prop('df_dt_emissao');
end;

function Tdocumento_fiscalDictionary.df_tipo_nf: TLinqProjection;
begin
  Result := Prop('df_tipo_nf');
end;

function Tdocumento_fiscalDictionary.df_valor: TLinqProjection;
begin
  Result := Prop('df_valor');
end;

function Tdocumento_fiscalDictionary.df_status: TLinqProjection;
begin
  Result := Prop('df_status');
end;

function Tdocumento_fiscalDictionary.df_protocolo: TLinqProjection;
begin
  Result := Prop('df_protocolo');
end;

function Tdocumento_fiscalDictionary.df_arquivo: TLinqProjection;
begin
  Result := Prop('df_arquivo');
end;

function Tdocumento_fiscalDictionary.df_dh_recebto: TLinqProjection;
begin
  Result := Prop('df_dh_recebto');
end;

{ TempresaDictionary }

function TempresaDictionary.emp_id: TLinqProjection;
begin
  Result := Prop('emp_id');
end;

function TempresaDictionary.emp_cnpj: TLinqProjection;
begin
  Result := Prop('emp_cnpj');
end;

function TempresaDictionary.emp_ie: TLinqProjection;
begin
  Result := Prop('emp_ie');
end;

function TempresaDictionary.emp_razao_social: TLinqProjection;
begin
  Result := Prop('emp_razao_social');
end;

function TempresaDictionary.emp_fantasia: TLinqProjection;
begin
  Result := Prop('emp_fantasia');
end;

function TempresaDictionary.emp_fone: TLinqProjection;
begin
  Result := Prop('emp_fone');
end;

function TempresaDictionary.emp_cep: TLinqProjection;
begin
  Result := Prop('emp_cep');
end;

function TempresaDictionary.emp_logradouro: TLinqProjection;
begin
  Result := Prop('emp_logradouro');
end;

function TempresaDictionary.emp_numero: TLinqProjection;
begin
  Result := Prop('emp_numero');
end;

function TempresaDictionary.emp_complemento: TLinqProjection;
begin
  Result := Prop('emp_complemento');
end;

function TempresaDictionary.emp_bairro: TLinqProjection;
begin
  Result := Prop('emp_bairro');
end;

function TempresaDictionary.emp_cod_cidade: TLinqProjection;
begin
  Result := Prop('emp_cod_cidade');
end;

function TempresaDictionary.emp_cidade: TLinqProjection;
begin
  Result := Prop('emp_cidade');
end;

function TempresaDictionary.emp_uf: TLinqProjection;
begin
  Result := Prop('emp_uf');
end;

function TempresaDictionary.emp_email_host: TLinqProjection;
begin
  Result := Prop('emp_email_host');
end;

function TempresaDictionary.emp_email_port: TLinqProjection;
begin
  Result := Prop('emp_email_port');
end;

function TempresaDictionary.emp_email_user: TLinqProjection;
begin
  Result := Prop('emp_email_user');
end;

function TempresaDictionary.emp_email_pass: TLinqProjection;
begin
  Result := Prop('emp_email_pass');
end;

function TempresaDictionary.emp_email_assunto: TLinqProjection;
begin
  Result := Prop('emp_email_assunto');
end;

function TempresaDictionary.emp_email_ssl: TLinqProjection;
begin
  Result := Prop('emp_email_ssl');
end;

function TempresaDictionary.emp_email_mensagem: TLinqProjection;
begin
  Result := Prop('emp_email_mensagem');
end;

function TempresaDictionary.emp_damfe_tipo: TLinqProjection;
begin
  Result := Prop('emp_damfe_tipo');
end;

{ Tfaturamento_detalheDictionary }

function Tfaturamento_detalheDictionary.fatd_id: TLinqProjection;
begin
  Result := Prop('fatd_id');
end;

function Tfaturamento_detalheDictionary.fk_doc: Idocumento_fiscalDictionary;
begin
  Result := Tdocumento_fiscalDictionary.Create(PropName('fk_doc'));
end;

function Tfaturamento_detalheDictionary.fk_fatm: Ifaturamento_mestreDictionary;
begin
  Result := Tfaturamento_mestreDictionary.Create(PropName('fk_fatm'));
end;

{ Tfaturamento_mestreDictionary }

function Tfaturamento_mestreDictionary.fatm_id: TLinqProjection;
begin
  Result := Prop('fatm_id');
end;

function Tfaturamento_mestreDictionary.fatm_periodo_inicial: TLinqProjection;
begin
  Result := Prop('fatm_periodo_inicial');
end;

function Tfaturamento_mestreDictionary.fatm_periodo_final: TLinqProjection;
begin
  Result := Prop('fatm_periodo_final');
end;

function Tfaturamento_mestreDictionary.fatm_qtd_notas: TLinqProjection;
begin
  Result := Prop('fatm_qtd_notas');
end;

function Tfaturamento_mestreDictionary.fatm_valor_por_nota_lida: TLinqProjection;
begin
  Result := Prop('fatm_valor_por_nota_lida');
end;

function Tfaturamento_mestreDictionary.fatm_total_notas: TLinqProjection;
begin
  Result := Prop('fatm_total_notas');
end;

function Tfaturamento_mestreDictionary.fk_emp: IempresaDictionary;
begin
  Result := TempresaDictionary.Create(PropName('fk_emp'));
end;

{ TtokenDictionary }

function TtokenDictionary.tok_id: TLinqProjection;
begin
  Result := Prop('tok_id');
end;

function TtokenDictionary.tok_token: TLinqProjection;
begin
  Result := Prop('tok_token');
end;

function TtokenDictionary.tok_duracao_seg: TLinqProjection;
begin
  Result := Prop('tok_duracao_seg');
end;

function TtokenDictionary.tok_chave: TLinqProjection;
begin
  Result := Prop('tok_chave');
end;

function TtokenDictionary.tok_data_hora: TLinqProjection;
begin
  Result := Prop('tok_data_hora');
end;

function TtokenDictionary.tok_password: TLinqProjection;
begin
  Result := Prop('tok_password');
end;

function TtokenDictionary.fk_emp: IempresaDictionary;
begin
  Result := TempresaDictionary.Create(PropName('fk_emp'));
end;

function TtokenDictionary.fk_usr: IusuarioDictionary;
begin
  Result := TusuarioDictionary.Create(PropName('fk_usr'));
end;

{ TusuarioDictionary }

function TusuarioDictionary.usr_id: TLinqProjection;
begin
  Result := Prop('usr_id');
end;

function TusuarioDictionary.usr_name: TLinqProjection;
begin
  Result := Prop('usr_name');
end;

function TusuarioDictionary.usr_password: TLinqProjection;
begin
  Result := Prop('usr_password');
end;

function TusuarioDictionary.usr_email: TLinqProjection;
begin
  Result := Prop('usr_email');
end;

function TusuarioDictionary.fk_emp: IempresaDictionary;
begin
  Result := TempresaDictionary.Create(PropName('fk_emp'));
end;

{ TDictionary }

function TDictionary.configuracao: IconfiguracaoDictionary;
begin
  Result := TconfiguracaoDictionary.Create;
end;

function TDictionary.consulta: IconsultaDictionary;
begin
  Result := TconsultaDictionary.Create;
end;

function TDictionary.documento_fiscal: Idocumento_fiscalDictionary;
begin
  Result := Tdocumento_fiscalDictionary.Create;
end;

function TDictionary.empresa: IempresaDictionary;
begin
  Result := TempresaDictionary.Create;
end;

function TDictionary.faturamento_detalhe: Ifaturamento_detalheDictionary;
begin
  Result := Tfaturamento_detalheDictionary.Create;
end;

function TDictionary.faturamento_mestre: Ifaturamento_mestreDictionary;
begin
  Result := Tfaturamento_mestreDictionary.Create;
end;

function TDictionary.token: ItokenDictionary;
begin
  Result := TtokenDictionary.Create;
end;

function TDictionary.usuario: IusuarioDictionary;
begin
  Result := TusuarioDictionary.Create;
end;

initialization
  RegisterEntity(Tconfiguracao);
  RegisterEntity(Tconsulta);
  RegisterEntity(Tdocumento_fiscal);
  RegisterEntity(Tempresa);
  RegisterEntity(Tfaturamento_detalhe);
  RegisterEntity(Tfaturamento_mestre);
  RegisterEntity(Ttoken);
  RegisterEntity(Tusuario);

end.
