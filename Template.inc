; �������������������������������������������������������������������������
; Include Files
; �������������������������������������������������������������������������

include windows.inc
include kernel32.inc
include user32.inc
include comctl32.inc
include advapi32.inc

; �������������������������������������������������������������������������
; Include libraries
; �������������������������������������������������������������������������

includelib kernel32.lib
includelib user32.lib
includelib comctl32.lib
includelib advapi32.lib

; �������������������������������������������������������������������������
; Function Prototypes
; �������������������������������������������������������������������������

DlgProc		proto	:HWND, :UINT, :WPARAM, :LPARAM		
GetRandomByte proto :DWORD, :BYTE, :BYTE