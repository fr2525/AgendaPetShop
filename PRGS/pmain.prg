********************************************************************** 
***
***    Programa : Main.prg (Programa Principal)
*** Descricao   : Programa principal da Aplicacao 
***  Par�metros : 
***       Notas : 
*** Programador : Fabio Reinert
***       Data  : 10 / Outubro /2001
***     Versi�n : 1.0
***    Historia : * 
***
**********************************************************************
Local lnWinHandle

*--- Limpeza do ambiente
CLEAR
CLEAR ALL

SET CLASSLIB TO reposito ADDITIVE
*** DECLARAMOS A FUNC�O API PARA LER DOS ARQUIVOS .INI

DECLARE INTEGER GetPrivateProfileString IN WIN32API;
	STRING Seccion,;
	STRING Clave,;
	STRING PorDefecto,;
	STRING @CadenaRetorno,;
	INTEGER longitud,;
	STRING NombreFichero

*** Declaramos as API para a cria��o do ODBC

DECLARE Integer RegOpenKeyEx IN Win32API ;
	Integer nKey, ;
	String cSubKey,;
	Integer nReserved, ;
	Integer nSamDesired, ;
	Integer @nResult

DECLARE Integer RegQueryValueEx In Win32API ;
	Integer nKey, ;
	String cValueName, ;
	Integer nReserved, ;
	Integer @nType, ;
	String @cData, ;
	Integer @nSizeData

DECLARE Integer RegCloseKey In Win32API ;
	Integer nKey

DECLARE Integer RegDeleteValue In WIN32API ;
	Integer  nKey, ;
	String cValueName

DECLARE Integer RegCreateKeyEx In Win32API ;
	Integer nKey, ;
	String cSubKey, ;
	Integer nReserved, ;
	String cClass, ;
	Integer nOptions,;
	Integer nDesired, ;
	String @cSecurityAttributes, ;
	Integer @nResult, ;
	Integer @nDisposition

DECLARE Integer RegSetValueEx In Win32API ;
	Integer nKey, ;
	String cValueName, ;
	Integer nReserved, ;
	Integer nType, ;
	String cData, ;
	Integer nSizeData

*** Declaro as API para manter ativa a tela de preview do report
	
*DECLARE LONG GetActiveWindow IN USER32

*DECLARE LONG IsWindow IN USER32 LONG hndventana
	
PUBLIC gousuario, goconfig
PUBLIC gDesenv

*--- verifica se o aplicativo est� sendo rodado dentro do VFP
* FILE() Verifica se o arquivo existe em disco
* HOME() Retorna o diretorio do 1o. programa executado

IF FILE(HOME()+"VFP.EXE") ;
OR FILE(HOME()+"VFP6.EXE") ;
OR FILE(HOME()+"VFP7.EXE") ; 
OR FILE(HOME()+"VFP8.EXE") ; 
OR FILE(HOME()+"VFP9.EXE") 
   m.gDesenv = .t.
ELSE
   m.gDesenv = .F.
ENDIF

*--> Variavel onde ser� armazenada a variavel indicadora de nivel de usuario
PUBLIC gNivel
*--> Variavel publica onde ser� guardado o codigo do operador
PUBLIC m.gOperador 
PUBLIC m.gEmpresa
PUBLIC m.gpalavra
PUBLIC m.gImpresso 
PUBLIC gSenha 
PUBLIC gDivcupom 
PUBLIC gMensa1 
PUBLIC gMensa2 
PUBLIC gDemo
PUBLIC oldTalk 
PUBLIC oldPath 
PUBLIC oldDate 
PUBLIC oldDel 
PUBLIC oldCurrency 
PUBLIC oldPoint 
PUBLIC oldSeparator 
PUBLIC oldExclusive 
PUBLIC oldReprocess 
PUBLIC oldRefresh 


gOperador = "Master"
gDemo = .F.

IF m.gDesenv 
*!*	   ** desabilita as op��es de desenvolvimento
*!*	   PUSH MENU _MSYSMENU
*!*	   IF WVISIBLE("project manager")
*!*	      DEACTIVATE WINDOW "project manager"
*!*	   ENDIF   
*!*	   IF WVISIBLE("standard")
*!*	      DEACTIVATE WINDOW "standard"
*!*	   ENDIF       	
*!*	       		   
*!*	   RELEASE WINDOWS "layout",;
*!*	                   "form controls".;
*!*	                   "report controls",;
*!*	                   "form designer",;
*!*	                   "database designer",;
*!*	                   "view designer",;
*!*	                   "query designer",;
*!*	                   "color pallete"
ELSE
   ON SHUTDOWN quit     && sai da aplica��o pelo X
ENDIF
                         		   
*--- Prepara��o do ambiente
* Salva configura��es

oldFundo = _screen.picture
oldTalk = SET("talk")
oldPath = SET("path")
oldDate = SET("date")
oldDel = SET("Deleted" )
oldCurrency = SET("Currency",1)
oldPoint = SET("point")
oldSeparator = SET("Separator")
oldExclusive = SET("Exclusive" )
oldReprocess = SET("Reprocess")
oldRefresh = SET("refresh")
*olderror = ON("error")

SET TALK OFF
SET NOTIFY OFF
SET CONSOLE OFF
SET DATE TO DMY
SET DELETED ON
SET CURRENCY TO "R$"
SET POINT TO ","
SET SEPARATOR TO "."
SET ENGINEBEHAVIOR 70

SET EXCLUSIVE OFF
SET REPROCESS TO 5
SET REFRESH TO 5

_SCREEN.WindowState = 2

*DO FORM frmsplash

PUBLIC lcdatabase

LOCAL lcPathAtual, lcPathNovo, lcNovo, lcAtual

CLOSE DATABASES all

****************************************************************************

*!*	*----- Part 1 -----*
*!*	* Create a recordset
*!*	* Sql Server name/address
*!*	lcSqlServer = "SQLTEST1"
*!*	* SQL 2000 sample DB
*!*	lcDb = "Pubs"
*!*	lcSql = "SELECT * FROM Sales"

*!*	* Open ADO connection
*!*	oCon = CREATEOBJECT("ADODB.Connection")
*!*	oCon.Open("Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;" + ;
*!*	"Initial Catalog=" + lcDb + ";Data Source=" + lcSqlServer)
*!*	* Create recordset
*!*	oRS = oCon.Execute(lcSql)

*!*	*----- Part 2 -----*
*!*	* Convert the ADO recordset to VFP cusor using CursorAdapter
*!*	oCA = CREATEOBJECT("CursorAdapter")
*!*	* Assign a cursor name
*!*	oCA.Alias = "crsRS"
*!*	oCA.DataSourceType = "ADO"
*!*	* Fill the cursor from the recordset
*!*	oCA.CursorFill(,,,oRS)
*!*	* Detach cursor so it still be open after CursorAdapter is destroyed
*!*	oCA.CursorDetach()
*!*	* Destroy CursorAdapter
*!*	oCA = NULL

*!*	BROWSE LAST NOWAIT

****************************************************************************

*: Establecemos los path con la creaci�n del objeto configuraci�n:*
*!*	goconfig = CREATEOBJECT('configura',curdir() + '\sgl.ini')


IF VERSION(2) = 0 && RunTime
    lcdatabase = goconfig.pdatabasepath  + 'DBSGL.dbc'
ELSE
    lcdatabase = SYS(5) + '\aplics\aplics_vfp9\sgl\dados\' +  'DBSGL.dbc'
endif

CLEAR

SELECT * FROM tab_loja INTO CURSOR crsLoja

*USE tab_loja
gEmpresa = CrsLoja.nome
gImpresso = CrsLoja.impresso
gPalavra = CrsLoja.palavra
gSenha = CrsLoja.senha
gDivcupom = CrsLoja.divcupom
gMensa1 = CrsLoja.Mensagem1
gMensa2 = CrsLoja.mensagem2 

Declare Integer FindWindow In Win32API Integer, String 
lnWinHandle = FindWindow( 0, "Sistema de Gerenciamento Comercial" )
If lnWinHandle # 0 
   =Messagebox( "O aplicativo j� est� sendo executado!", 16 )
   Cancel
ENDIF

IF VERSION(2) = 0 && RunTime
*!*	   MESSAGEBOX("EXECUT�VEL")
	*: Ativamos o formulario de entrada que n�o esta visivel :*
	DO FORM frmlogin

	*{ Ocultamos a tela do fox }*
	_SCREEN.Hide

	*( Criamos o objeto de criptografia )*
	gOcripta = CREATEOBJECT('crypto')


*!*		*{ Mostramos o formul�rio de entrada}*
*!*	    frmprinc.caption = frmprinc.caption + " - " + gEmpresa 
*!*		frmLogin.show()
ELSE
*!*	   MESSAGEBOX("DESENVOLVIMENTO")
   gNivel = 1
   DO FORM frmprinc

	*{ Ocultamos a tela do fox }*
	_SCREEN.Hide
   
*   frmprinc.picture = "figura.bmp"
   frmprinc.caption = frmprinc.caption + " - " + gEmpresa 
   frmprinc.show

ENDIF

READ EVENTS


