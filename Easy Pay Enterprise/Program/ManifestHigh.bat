@ECHO OFF
CLS

IF EXIST Core.exe (
mt.exe -manifest CoreHigh.exe.manifest -outputresource:Core.exe;1
)ELSE (
ECHO Manifest Err - Missing Core.exe
)

IF EXIST EPEControl.exe (
mt.exe -manifest EPEControlHigh.exe.manifest -outputresource:EPEControl.exe;1
)ELSE (
ECHO Manifest Err - Missing EPEControl.exe
)

IF EXIST EPEUpdate.exe (
mt.exe -manifest EPEUpdateHigh.exe.manifest -outputresource:EPEUpdate.exe;1
)ELSE (
ECHO Manifest Err - Missing EPEUpdate.exe
)

IF EXIST EPStandard.exe (
mt.exe -manifest EPStandardHigh.exe.manifest -outputresource:EPStandard.exe;1
)ELSE (
ECHO Manifest Err - Missing EPStandard.exe
)

