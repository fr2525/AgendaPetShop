DEFINE CLASS HeadOrden AS Header
	Alignment = 2
	FontSize  = 8
	Orden     = ''

    Procedure Init
       Lparameters pCampo, pIndiceCol
       Local cIndiceAsc, cIndiceDes
       
	   This.BackColor = Rgb(255, 255, 200)
	   This.ForeColor = Rgb(0, 64, 128)
	   
	   cIndiceAsc = 'Index On ' + pCampo + ' Tag Clave' + Alltrim(Str(pIndiceCol)) + ' Additive'	 
	   &cIndiceAsc 	      
	   cIndiceDes = 'Index On ' + pCampo + ' Tag Clave' + Alltrim(Str(pIndiceCol)) + 'd Descending Additive'	   	      
	   &cIndiceDes 
	   
	   This.Orden = Alltrim(Str(pIndiceCol))
    EndProc
    
	Procedure Click
	    Local Ejecutar
	    
		If !CursorVacio(This.Parent.Parent.RecordSource)
		    If Type('This.Parent.Parent.Header') == 'O' And !Isnull(This.Parent.Parent.Header)
		        This.Parent.Parent.Header.BackColor = Rgb(255, 255, 200)
		    EndIf
					
		    Ejecutar = 'Set Order To Clave' + This.Orden + ' In ' + This.Parent.Parent.RecordSource
			&Ejecutar
			
			This.Parent.Parent.Header = This			
			This.BackColor = Rgb(181, 211, 171)
						
			Go Top In (This.Parent.Parent.RecordSource)
			This.Parent.Parent.Refresh()
		Endif
	Endproc
	
	Procedure RightClick	   
	    Local Ejecutar
	    
		If !CursorVacio(This.Parent.Parent.RecordSource) 
		    If Type('This.Parent.Parent.Header') == 'O' And !Isnull(This.Parent.Parent.Header)
		      This.Parent.Parent.Header.BackColor = Rgb(255, 255, 200)
		    EndIf
					
            Ejecutar = 'Set Order To Clave' + This.Orden + 'd In ' + This.Parent.Parent.RecordSource
			&Ejecutar

			This.Parent.Parent.Header = This		
		    This.BackColor = Rgb(222, 164, 160)
						
			Go Top In (This.Parent.Parent.RecordSource)
			This.Parent.Parent.Refresh()						
		Endif        
	Endproc
Enddefine

** Funci�n que devuelve .t. cuando el cursor cCursor est� vac�o
Function CursorVacio
   Lparameters cCursor   
   Local lEstaVacio
      
   Go Top In &cCursor
   lEstaVacio = Iif(Eof(cCursor), .t., .f.)   
Return lEstaVacio
