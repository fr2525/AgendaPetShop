DECLARE INTEGER GetPrivateProfileString IN WIN32API;
	STRING Seccion,;
	STRING Clave,;
	STRING PorDefecto,;
	STRING @CadenaRetorno,;
	INTEGER longitud,;
	STRING NombreFichero

PUBLIC m.pnivel,m.data,gOperador, gDesenv
PUBLIC m.gEmpresa
PUBLIC m.gpalavra
PUBLIC m.gImpresso 
PUBLIC gSenha 
PUBLIC gDivcupom 
PUBLIC gMensa1 
PUBLIC gMensa2 
PUBLIC gDemo
PUBLIC lcdatabase

M.DATA = DATE() 
gOperador = 'MASTER' 
gNivel=1
gSenha = .T.
gDesenv = .T.
gEmpresa = "Empresa Demo"
gPalavra = "Or�amento"
gImpresso = "80"
gDivcupom = .F. 
gMensa1 = "Mensagem 1"
gMensa2 = "Mensagem 2"

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


gOperador = "99"
gDemo = .F.

*!*	SET DEFA TO
*!*	letra = INPUTBOX("Digite a letra do Pen Drive: ")
*!*	letra = "D"
*!*	letra = letra + ":"
*!*	SET DEFAULT TO (letra)

vPath = ""
vPath = vPath + SYS(5) +  CURDIR() + ";"
vPath = vPath + SYS(5) +  CURDIR() + "Classes;" + SYS(5) +  CURDIR() + "forms;"
vPath = vPath + SYS(5) +  CURDIR() + "menus;"   + SYS(5) +  CURDIR() + "prgs;" 
vPath = vPath + SYS(5) +  CURDIR() + "rpts;"    + SYS(5) +  CURDIR() + "dados;" 
vPath = vPath + SYS(5) +  CURDIR() + "bitmaps;"
SET PATH TO &vPath

SET CLASSLIB TO reposito ADDITIVE

*: Establecemos los path con la creaci�n del objeto configuraci�n:*
*	goconfig = CREATEOBJECT('configura','c:\sgl.ini')
	*goConfig.pcini = GETENV("windir") + "dbsMG.INI"

*!*	*{ Abertura da base de dados }*

lcdatabase = '.\dados\dbsgl.dbc'
OPEN DATABASE (lcdatabase) shared
SET DATABASE TO DbSGL

*!*	*lcdatabase = SYS(5) + SYS(2003) +"\Dados\" +  'dbsmg.dbc'
*!*	*SET DEFA TO &goconfig.pdatabasepath
*!*	*OPEN DATABASE Dbsgl.mdb SHARED 
*!*	OPEN DATABASE (lcdatabase)
*!*	*SET DATABASE TO (lcdatabase)

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

SET DATE BRITI
SET CENTURY ON
SET CURRENCY TO 'R$'
SET SEPARATOR TO '.'
SET POINT TO ','
SET ENGINEBEHAVIOR 70

*SET CLOCK ON
*SET PROCEDURE TO funcoes.prg

