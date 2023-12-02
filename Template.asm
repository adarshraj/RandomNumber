; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; General Asm Template by Lahar 
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

.686					;Use 686 instuction set to have all inel commands
.model flat, stdcall	;Use flat memory model since we are in 32bit 
option casemap: none	;Variables and others are case sensitive

include Template.inc	;Include our files containing libraries

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our initialised variables will go into in this .data section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.data
	szAppName	db	"Random Number",0
	szFormat	db	"%lu",0

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our uninitialised variables will go into in this .data? section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.data?
	hInstance	HINSTANCE	?
	hProv         	dd    ?
    ddRandom      	dd    ?
    szOut			db	  120 dup(?)	

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; Our constant values will go onto this section
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.const
	IDD_DLGBOX	equ	1001
	IDC_EXIT	equ	1002
	APP_ICON	equ	2000
	
	PROV_RSA_FULL        	equ    1
    CRYPT_VERIFYCONTEXT    	equ    0F0000000h

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; This is the section to write our main code
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
.code

start:	
	invoke GetModuleHandle, NULL
	mov hInstance, eax
	invoke InitCommonControls
	invoke DialogBoxParam, hInstance, IDD_DLGBOX, NULL, addr DlgProc, NULL
	invoke ExitProcess, NULL

DlgProc		proc	hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	.if uMsg == WM_INITDIALOG
		invoke SetWindowText, hWnd, addr szAppName
		invoke LoadIcon, hInstance, APP_ICON
		invoke SendMessage, hWnd, WM_SETICON, 1, eax
		;invoke SetTimer, hWnd,NULL,100,NULL
		
	.elseif uMsg == WM_COMMAND
		mov eax, wParam
		.if eax == IDC_EXIT
			invoke SendMessage, hWnd, WM_CLOSE, 0, 0
		.elseif eax == 1004
			invoke CryptAcquireContext,addr hProv, NULL, NULL, PROV_RSA_FULL,CRYPT_VERIFYCONTEXT
   	 		invoke CryptGenRandom, hProv, sizeof DWORD, addr ddRandom
   	 		
   	 		;If u need in a custmom Range
   	 		;invoke GetRandomByte, hProv, 'A', 'Z'
    		;invoke wsprintf, addr szOut, addr szFormat, eax
    		
    		invoke wsprintf, addr szOut, addr szFormat, ddRandom
    		invoke SetDlgItemText, hWnd, 1003, addr szOut
    		invoke CryptReleaseContext, hProv, NULL	
		.endif
	.elseif uMsg == WM_TIMER

	.elseif uMsg == WM_CLOSE
		invoke EndDialog, hWnd, NULL
	.endif
	
	xor eax, eax				 
	Ret
DlgProc EndP

;Proc bu ufo-pussy
GetRandomByte proc prov:DWORD,min:BYTE,max:BYTE
    LOCAL output:BYTE
    
    .repeat
        invoke CryptGenRandom,prov,1,addr output
        mov al,output
    .until al >= min && al <= max
    
    ret
GetRandomByte endp

end start	
	 