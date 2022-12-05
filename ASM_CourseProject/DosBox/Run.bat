@echo off

rem #修改此處路徑至 dos.exe 安裝位置
@set DOSBOX="DOSBox-0.74-3\DOSBox.exe"
%DOSBOX% -c "MOUNT C H:\UseFolder\NCU_Course\1111\ASM\CourseProject\ASM_CourseProject\DosBox" -c "C:" -c "TASM.EXE MAIN.ASM" -c "TLINK.EXE MAIN.OBJ" -c "MAIN.EXE" -c "WAITKEY.EXE" -c "exit" -noconsole
