unit DOpenDSS;

{
  Delphi translation of the OpenDSS() and API_docs() unified-interface functions
  found in the VersionC (C++) port at DLL/OpenDSSCDLL.cpp / DLL/OpenDSSCDLL.h.

  OpenDSS() is a single entry point that multiplexes every classic interface
  function declared across the units in this DDLL folder (DDSS, DLines, DText,
  DCapacitors, ... one call per DSS class/category, each with an *I/*F/*S/*V
  variant). Function = FunctionBase * 1000 + mode, where FunctionBase selects
  which underlying function gets called (see TOpenDSSFunctionBase below) and
  mode is passed straight through as that function's "mode" argument.

  myPointer/myType/mySize is an in/out triple following exactly the convention
  already used by the *V() functions throughout this codebase (see LinesV for
  reference):
    - On entry, myPointer holds the address of a buffer holding whatever
      argument the selected function expects: one integer, one double, two
      doubles, a null-terminated string, or is unused (functions with no
      argument still expect a valid myPointer; its contents are ignored).
      myType/mySize describe that incoming buffer using the same codes used
      by the *V() functions: 0 - Boolean, 1 - Integer, 2 - Double,
      3 - Complex (array of doubles), 4 - String.
    - On return, OpenDSS() overwrites myPointer/myType/mySize to describe the
      outgoing result using that same convention (functions returning nothing
      report mySize = 0).
    - For FunctionBase values ending in "V" (fnDSSV, fnLinesV, ...),
      myPointer/myType/mySize are simply forwarded to the underlying *V()
      function unchanged.

  Excluded from this dispatcher, same as in the C++ port: InitAndGetYparams,
  GetCompressedYMatrix, SolveSystem, getIpointer, getVpointer. Their arguments
  are raw handles/pointer-to-pointer outputs that don't fit the single
  (Type, Size) value description above, so they remain direct exports only.
}

interface

uses
  DSSGlobals;

const
  // Mirrors "enum TOpenDSSFunctionBase" in OpenDSSCDLL.h - keep values in sync.
  fnDSSI                 = 0;
  fnDSSS                 = 1;
  fnDSSV                 = 2;
  fnLinesI                = 3;
  fnLinesF                = 4;
  fnLinesS                = 5;
  fnLinesV                = 6;
  fnDSSPutCommand         = 7;
  fnDSSLoadsI             = 8;
  fnDSSLoadsF             = 9;
  fnDSSLoadsS             = 10;
  fnDSSLoadsV             = 11;
  fnCapacitorsI           = 12;
  fnCapacitorsF           = 13;
  fnCapacitorsS           = 14;
  fnCapacitorsV           = 15;
  fnActiveClassI          = 16;
  fnActiveClassS          = 17;
  fnActiveClassV          = 18;
  fnBUSI                  = 19;
  fnBUSF                  = 20;
  fnBUSS                  = 21;
  fnBUSV                  = 22;
  fnCapControlsI          = 23;
  fnCapControlsF          = 24;
  fnCapControlsS          = 25;
  fnCapControlsV          = 26;
  fnCircuitI              = 27;
  fnCircuitF              = 28;   // takes two doubles (arg1, arg2)
  fnCircuitS              = 29;
  fnCircuitV              = 30;
  fnCktElementI           = 31;
  fnCktElementF           = 32;
  fnCktElementS           = 33;
  fnCktElementV           = 34;
  fnCmathLibF             = 35;   // takes two doubles (arg1, arg2)
  fnCmathLibV             = 36;
  fnGeneratorsI           = 37;
  fnGeneratorsF           = 38;
  fnGeneratorsS           = 39;
  fnGeneratorsV           = 40;
  fnDSSElementI           = 41;
  fnDSSElementS           = 42;
  fnDSSElementV           = 43;
  fnDSSProgressI          = 44;
  fnDSSProgressS          = 45;
  fnDSSExecutiveI         = 46;
  fnDSSExecutiveS         = 47;
  fnErrorCode             = 48;
  fnErrorDesc             = 49;
  fnFusesI                = 50;
  fnFusesF                = 51;
  fnFusesS                = 52;
  fnFusesV                = 53;
  fnGICSourcesI           = 54;
  fnGICSourcesF           = 55;
  fnGICSourcesS           = 56;
  fnGICSourcesV           = 57;
  fnIsourceI              = 58;
  fnIsourceF              = 59;
  fnIsourceS              = 60;
  fnIsourceV              = 61;
  fnLineCodesI            = 62;
  fnLineCodesF            = 63;
  fnLineCodesS            = 64;
  fnLineCodesV            = 65;
  fnLoadShapeI            = 66;
  fnLoadShapeF            = 67;
  fnLoadShapeS            = 68;
  fnLoadShapeV            = 69;
  fnMetersI               = 70;
  fnMetersF               = 71;
  fnMetersS               = 72;
  fnMetersV               = 73;
  fnMonitorsI             = 74;
  fnMonitorsS             = 75;
  fnMonitorsV             = 76;
  fnParallelI             = 77;
  fnParallelV             = 78;
  fnParserI               = 79;
  fnParserF               = 80;
  fnParserS               = 81;
  fnParserV               = 82;
  fnPDElementsI           = 83;
  fnPDElementsF           = 84;
  fnPDElementsS           = 85;
  fnPVsystemsI            = 86;
  fnPVsystemsF            = 87;
  fnPVsystemsS            = 88;
  fnPVsystemsV            = 89;
  fnReactorsI             = 90;
  fnReactorsF             = 91;
  fnReactorsS             = 92;
  fnReactorsV             = 93;
  fnReclosersI            = 94;
  fnReclosersF            = 95;
  fnReclosersS            = 96;
  fnReclosersV            = 97;
  fnReduceCktI            = 98;
  fnReduceCktF            = 99;
  fnReduceCktS            = 100;
  fnRegControlsI          = 101;
  fnRegControlsF          = 102;
  fnRegControlsS          = 103;
  fnRegControlsV          = 104;
  fnRelaysI               = 105;
  fnRelaysS               = 106;
  fnRelaysV               = 107;
  fnSensorsI              = 108;
  fnSensorsF              = 109;
  fnSensorsS              = 110;
  fnSensorsV              = 111;
  fnSettingsI             = 112;
  fnSettingsF             = 113;
  fnSettingsS             = 114;
  fnSettingsV             = 115;
  fnSolutionI             = 116;
  fnSolutionF             = 117;
  fnSolutionS             = 118;
  fnSolutionV             = 119;
  fnStoragesI             = 120;
  fnStoragesF             = 121;
  fnStoragesS             = 122;
  fnStoragesV             = 123;
  fnSwtControlsI          = 124;
  fnSwtControlsF          = 125;
  fnSwtControlsS          = 126;
  fnSwtControlsV          = 127;
  fnTopologyI             = 128;
  fnTopologyS             = 129;
  fnTopologyV             = 130;
  fnTransformersI         = 131;
  fnTransformersF         = 132;
  fnTransformersS         = 133;
  fnTransformersV         = 134;
  fnVsourcesI             = 135;
  fnVsourcesF             = 136;
  fnVsourcesS             = 137;
  fnVsourcesV             = 138;
  fnWindGensI             = 139;
  fnWindGensF             = 140;
  fnWindGensS             = 141;
  fnWindGensV             = 142;
  fnXYCurvesI             = 143;
  fnXYCurvesF             = 144;
  fnXYCurvesS             = 145;
  fnXYCurvesV             = 146;
  fnCtrlQueueI            = 147;
  fnCtrlQueueV            = 148;
  fnDSSProperties         = 149;
  fnSystemYChanged        = 150;
  fnUseAuxCurrents        = 151;
  fnAddInAuxCurrents      = 152;  // takes one int (SType), no mode
  fnBuildYMatrixD         = 153;  // takes two ints (BuildOps, AllocateVI), no mode
  fnGetPCInjCurr          = 154;  // no argument, no mode
  fnGetSourceInjCurrents  = 155;  // no argument, no mode
  fnZeroInjCurr           = 156;  // no argument, no mode
  fnDSSDisposeString      = 157;  // takes the string pointer to dispose, no mode

// Unified (OpenDSS) interface: multiplexes every *I/*F/*S/*V function in this
// DDLL folder through a single entry point. See the unit header comment above.
procedure OpenDSS(FunctionCode: longint; var myPointer: Pointer; var myType, mySize: longint); cdecl;

// Returns the documentation entry for the given API_docs table index as
// "FunctionCode, argtype, Class.Property, description", or
// "-1, no more parameters implemented" once index runs past the table.
// Callers should keep incrementing index from 0 until they get that string back.
function API_docs(index: longint): pAnsiChar; cdecl;

// DSSDisposeString does not exist in this Delphi DLL's classic interface: strings
// returned by the *S() functions here are transient AnsiStrings reclaimed
// automatically by Delphi's (ShareMem-backed) memory manager, unlike the VersionC
// C++ port, which hands back a manually `new char[]`-allocated buffer that its
// callers must free explicitly. This entry point is provided only so client code
// written against that C++ port's calling convention links and runs unmodified
// against this DLL; it is intentionally a no-op.
procedure DSSDisposeString(value: pAnsiChar); cdecl;

implementation

uses
  SysUtils,
  DDSS, DLines, DText, DLoads, DCapacitors, DActiveClass, DBus, DCapControls,
  DCircuit, DCktElement, DCmathLib, DGenerators, DDSSElement, DDSSProgress,
  DDSSExecutive, DError, DFuses, DGICSources, DISource, DLineCodes, DLoadShape,
  DMeters, DMonitors, DParallel, DParser, DPDELements, DPVSystems, DReactors,
  DReclosers, DReduceCkt, DRegControls, DRelays, DSensors, DSettings, DSolution,
  DStorages, DSwtControls, DTopology, DTransformers, DVSources, DWindGens,
  DXYCurves, DCtrlQueue, DIDSSProperty, DYMatrix;

{$I APIDocsData.pas.inc}

//--------------------------------------------------------------------------------
// Unified interface (OpenDSS) - helpers
//--------------------------------------------------------------------------------
// Reads back the buffer address the caller placed in myPointer and reinterprets
// it as the argument type the target function expects. See the unit header
// comment for the calling convention (myPointer already IS the buffer address,
// matching how every *V() function in this codebase already treats it).
function OpenDSS_UnpackInt(myPointer: Pointer; idx: Integer = 0): Integer;
var
  j : Integer;
begin
  for j := 0 to idx do
  Begin
    Result := PInteger(myPointer)^;
    inc(PByte(myPointer),SizeOf(integer));
  End;
end;

function OpenDSS_UnpackDouble(myPointer: Pointer; idx: Integer = 0): Double;
var
  j : Integer;
begin
  for j := 0 to idx do
  Begin
    Result := PDouble(myPointer)^;
    inc(PByte(myPointer),SizeOf(double));
  End;
end;

function OpenDSS_UnpackString(myPointer: Pointer): pAnsiChar;
var
  j: Integer;
begin
  j := 0;
  Result := pAnsiChar(AnsiString(BArray2Str(myPointer, j)));
end;

// Packs a scalar result into the shared global buffers (the same myIntArray /
// myDBLArray / myStrArray used by the *V() functions) and points
// myPointer/myType/mySize at it, mirroring how e.g. WindGensV publishes its results.
procedure OpenDSS_PackInt(value: Integer; var myPointer: Pointer; var myType, mySize: longint);
begin
  SetLength(myIntArray, 1);
  myIntArray[0] := value;
  myType := 1;      // Integer
  myPointer := @(myIntArray[0]);
  mySize := SizeOf(Integer);
end;

procedure OpenDSS_PackDouble(value: Double; var myPointer: Pointer; var myType, mySize: longint);
begin
  SetLength(myDBLArray, 1);
  myDBLArray[0] := value;
  myType := 2;      // Double
  myPointer := @(myDBLArray[0]);
  mySize := SizeOf(Double);
end;

procedure OpenDSS_PackString(const value: String; var myPointer: Pointer; var myType, mySize: longint);
begin
  SetLength(myStrArray, 0);
  WriteStr2Array(value);
  WriteStr2Array(Char(0));
  myType := 4;      // String
  myPointer := @(myStrArray[0]);
  mySize := Length(myStrArray);
end;

// The *S() functions all hand back a pAnsiChar (typically a transient AnsiString
// cast to pAnsiChar - see e.g. LinesS, CapacitorsS, ErrorDesc); copy it into
// myStrArray, mirroring OpenDSS_PackAndFreeString in the C++ port (there, the
// *S() functions return a heap buffer that gets freed after copying it out; here,
// Delphi's memory manager reclaims the transient string on its own).
procedure OpenDSS_PackAndFreeString(value: pAnsiChar; var myPointer: Pointer; var myType, mySize: longint);
begin
  OpenDSS_PackString(String(value), myPointer, myType, mySize);
end;

// Used by void functions: nothing to hand back.
procedure OpenDSS_PackNone(var myType, mySize: longint);
begin
  myType := 1;
  mySize := 0;
end;

//--------------------------------------------------------------------------------
// Implements the Unified (OpenDSS) interface for the DLL
//--------------------------------------------------------------------------------
procedure OpenDSS(FunctionCode: longint; var myPointer: Pointer; var myType, mySize: longint); cdecl;
var
  Base, mode: longint;
begin
  Base := FunctionCode div 1000;
  mode := FunctionCode mod 1000;

  case Base of
    fnDSSI            : OpenDSS_PackInt(DSSI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnDSSS            : OpenDSS_PackAndFreeString(DSSS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnDSSV            : DSSV(mode, myPointer, myType, mySize);
    fnLinesI          : OpenDSS_PackInt(LinesI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnLinesF          : OpenDSS_PackDouble(LinesF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnLinesS          : OpenDSS_PackAndFreeString(LinesS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnLinesV          : LinesV(mode, myPointer, myType, mySize);
    fnDSSPutCommand   : OpenDSS_PackAndFreeString(DSSPut_Command(OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnDSSLoadsI       : OpenDSS_PackInt(DSSLoads(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnDSSLoadsF       : OpenDSS_PackDouble(DSSLoadsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnDSSLoadsS       : OpenDSS_PackAndFreeString(DSSLoadsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnDSSLoadsV       : DSSLoadsV(mode, myPointer, myType, mySize);
    fnCapacitorsI     : OpenDSS_PackInt(CapacitorsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnCapacitorsF     : OpenDSS_PackDouble(CapacitorsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnCapacitorsS     : OpenDSS_PackAndFreeString(CapacitorsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnCapacitorsV     : CapacitorsV(mode, myPointer, myType, mySize);
    fnActiveClassI    : OpenDSS_PackInt(ActiveClassI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnActiveClassS    : OpenDSS_PackAndFreeString(ActiveClassS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnActiveClassV    : ActiveClassV(mode, myPointer, myType, mySize);
    fnBUSI            : OpenDSS_PackInt(BUSI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnBUSF            : OpenDSS_PackDouble(BUSF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnBUSS            : OpenDSS_PackAndFreeString(BUSS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnBUSV            : BUSV(mode, myPointer, myType, mySize);
    fnCapControlsI    : OpenDSS_PackInt(CapControlsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnCapControlsF    : OpenDSS_PackDouble(CapControlsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnCapControlsS    : OpenDSS_PackAndFreeString(CapControlsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnCapControlsV    : CapControlsV(mode, myPointer, myType, mySize);
    fnCircuitI        : OpenDSS_PackInt(CircuitI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnCircuitF        : OpenDSS_PackDouble(CircuitF(mode, OpenDSS_UnpackDouble(myPointer, 0), OpenDSS_UnpackDouble(myPointer, 1)), myPointer, myType, mySize);
    fnCircuitS        : OpenDSS_PackAndFreeString(CircuitS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnCircuitV        : CircuitV(mode, myPointer, myType, mySize);
    fnCktElementI     : OpenDSS_PackInt(CktElementI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnCktElementF     : OpenDSS_PackDouble(CktElementF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnCktElementS     : OpenDSS_PackAndFreeString(CktElementS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnCktElementV     : CktElementV(mode, myPointer, myType, mySize);
    fnCmathLibF       : OpenDSS_PackDouble(CmathLibF(mode, OpenDSS_UnpackDouble(myPointer, 0), OpenDSS_UnpackDouble(myPointer, 1)), myPointer, myType, mySize);
    fnCmathLibV       : CmathLibV(mode, myPointer, myType, mySize);
    fnGeneratorsI     : OpenDSS_PackInt(GeneratorsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnGeneratorsF     : OpenDSS_PackDouble(GeneratorsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnGeneratorsS     : OpenDSS_PackAndFreeString(GeneratorsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnGeneratorsV     : GeneratorsV(mode, myPointer, myType, mySize);
    fnDSSElementI     : OpenDSS_PackInt(DSSElementI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnDSSElementS     : OpenDSS_PackAndFreeString(DSSElementS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnDSSElementV     : DSSElementV(mode, myPointer, myType, mySize);
    fnDSSProgressI    : OpenDSS_PackInt(DSSProgressI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnDSSProgressS    : OpenDSS_PackAndFreeString(DSSProgressS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnDSSExecutiveI   : OpenDSS_PackInt(DSSExecutiveI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnDSSExecutiveS   : OpenDSS_PackAndFreeString(DSSExecutiveS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnErrorCode       : OpenDSS_PackInt(ErrorCode(), myPointer, myType, mySize);
    fnErrorDesc       : OpenDSS_PackAndFreeString(ErrorDesc(), myPointer, myType, mySize);
    fnFusesI          : OpenDSS_PackInt(FusesI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnFusesF          : OpenDSS_PackDouble(FusesF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnFusesS          : OpenDSS_PackAndFreeString(FusesS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnFusesV          : FusesV(mode, myPointer, myType, mySize);
    fnGICSourcesI     : OpenDSS_PackInt(GICSourcesI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnGICSourcesF     : OpenDSS_PackDouble(GICSourcesF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnGICSourcesS     : OpenDSS_PackAndFreeString(GICSourcesS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnGICSourcesV     : GICSourcesV(mode, myPointer, myType, mySize);
    fnIsourceI        : OpenDSS_PackInt(IsourceI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnIsourceF        : OpenDSS_PackDouble(IsourceF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnIsourceS        : OpenDSS_PackAndFreeString(IsourceS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnIsourceV        : IsourceV(mode, myPointer, myType, mySize);
    fnLineCodesI      : OpenDSS_PackInt(LineCodesI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnLineCodesF      : OpenDSS_PackDouble(LineCodesF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnLineCodesS      : OpenDSS_PackAndFreeString(LineCodesS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnLineCodesV      : LineCodesV(mode, myPointer, myType, mySize);
    fnLoadShapeI      : OpenDSS_PackInt(LoadShapeI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnLoadShapeF      : OpenDSS_PackDouble(LoadShapeF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnLoadShapeS      : OpenDSS_PackAndFreeString(LoadShapeS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnLoadShapeV      : LoadShapeV(mode, myPointer, myType, mySize);
    fnMetersI         : OpenDSS_PackInt(MetersI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnMetersF         : OpenDSS_PackDouble(MetersF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnMetersS         : OpenDSS_PackAndFreeString(MetersS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnMetersV         : MetersV(mode, myPointer, myType, mySize);
    fnMonitorsI       : OpenDSS_PackInt(MonitorsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnMonitorsS       : OpenDSS_PackAndFreeString(MonitorsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnMonitorsV       : MonitorsV(mode, myPointer, myType, mySize);
    fnParallelI       : OpenDSS_PackInt(ParallelI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnParallelV       : ParallelV(mode, myPointer, myType, mySize);
    fnParserI         : OpenDSS_PackInt(ParserI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnParserF         : OpenDSS_PackDouble(ParserF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnParserS         : OpenDSS_PackAndFreeString(ParserS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnParserV         : ParserV(mode, myPointer, myType, mySize);
    fnPDElementsI     : OpenDSS_PackInt(PDElementsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnPDElementsF     : OpenDSS_PackDouble(PDElementsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnPDElementsS     : OpenDSS_PackAndFreeString(PDElementsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnPVsystemsI      : OpenDSS_PackInt(PVsystemsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnPVsystemsF      : OpenDSS_PackDouble(PVsystemsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnPVsystemsS      : OpenDSS_PackAndFreeString(PVsystemsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnPVsystemsV      : PVsystemsV(mode, myPointer, myType, mySize);
    fnReactorsI       : OpenDSS_PackInt(ReactorsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnReactorsF       : OpenDSS_PackDouble(ReactorsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnReactorsS       : OpenDSS_PackAndFreeString(ReactorsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnReactorsV       : ReactorsV(mode, myPointer, myType, mySize);
    fnReclosersI      : OpenDSS_PackInt(ReclosersI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnReclosersF      : OpenDSS_PackDouble(ReclosersF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnReclosersS      : OpenDSS_PackAndFreeString(ReclosersS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnReclosersV      : ReclosersV(mode, myPointer, myType, mySize);
    fnReduceCktI      : OpenDSS_PackInt(ReduceCktI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnReduceCktF      : OpenDSS_PackDouble(ReduceCktF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnReduceCktS      : OpenDSS_PackAndFreeString(ReduceCktS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnRegControlsI    : OpenDSS_PackInt(RegControlsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnRegControlsF    : OpenDSS_PackDouble(RegControlsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnRegControlsS    : OpenDSS_PackAndFreeString(RegControlsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnRegControlsV    : RegControlsV(mode, myPointer, myType, mySize);
    fnRelaysI         : OpenDSS_PackInt(RelaysI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnRelaysS         : OpenDSS_PackAndFreeString(RelaysS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnRelaysV         : RelaysV(mode, myPointer, myType, mySize);
    fnSensorsI        : OpenDSS_PackInt(SensorsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnSensorsF        : OpenDSS_PackDouble(SensorsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnSensorsS        : OpenDSS_PackAndFreeString(SensorsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnSensorsV        : SensorsV(mode, myPointer, myType, mySize);
    fnSettingsI       : OpenDSS_PackInt(SettingsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnSettingsF       : OpenDSS_PackDouble(SettingsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnSettingsS       : OpenDSS_PackAndFreeString(SettingsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnSettingsV       : SettingsV(mode, myPointer, myType, mySize);
    fnSolutionI       : OpenDSS_PackInt(SolutionI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnSolutionF       : OpenDSS_PackDouble(SolutionF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnSolutionS       : OpenDSS_PackAndFreeString(SolutionS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnSolutionV       : SolutionV(mode, myPointer, myType, mySize);
    fnStoragesI       : OpenDSS_PackInt(StoragesI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnStoragesF       : OpenDSS_PackDouble(StoragesF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnStoragesS       : OpenDSS_PackAndFreeString(StoragesS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnStoragesV       : StoragesV(mode, myPointer, myType, mySize);
    fnSwtControlsI    : OpenDSS_PackInt(SwtControlsI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnSwtControlsF    : OpenDSS_PackDouble(SwtControlsF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnSwtControlsS    : OpenDSS_PackAndFreeString(SwtControlsS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnSwtControlsV    : SwtControlsV(mode, myPointer, myType, mySize);
    fnTopologyI       : OpenDSS_PackInt(TopologyI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnTopologyS       : OpenDSS_PackAndFreeString(TopologyS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnTopologyV       : TopologyV(mode, myPointer, myType, mySize);
    fnTransformersI   : OpenDSS_PackInt(TransformersI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnTransformersF   : OpenDSS_PackDouble(TransformersF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnTransformersS   : OpenDSS_PackAndFreeString(TransformersS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnTransformersV   : TransformersV(mode, myPointer, myType, mySize);
    fnVsourcesI       : OpenDSS_PackInt(VsourcesI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnVsourcesF       : OpenDSS_PackDouble(VsourcesF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnVsourcesS       : OpenDSS_PackAndFreeString(VsourcesS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnVsourcesV       : VsourcesV(mode, myPointer, myType, mySize);
    fnWindGensI       : OpenDSS_PackInt(WindGensI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnWindGensF       : OpenDSS_PackDouble(WindGensF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnWindGensS       : OpenDSS_PackAndFreeString(WindGensS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnWindGensV       : WindGensV(mode, myPointer, myType, mySize);
    fnXYCurvesI       : OpenDSS_PackInt(XYCurvesI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnXYCurvesF       : OpenDSS_PackDouble(XYCurvesF(mode, OpenDSS_UnpackDouble(myPointer)), myPointer, myType, mySize);
    fnXYCurvesS       : OpenDSS_PackAndFreeString(XYCurvesS(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnXYCurvesV       : XYCurvesV(mode, myPointer, myType, mySize);
    fnCtrlQueueI      : OpenDSS_PackInt(CtrlQueueI(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnCtrlQueueV      : CtrlQueueV(mode, myPointer, myType, mySize);
    fnDSSProperties   : OpenDSS_PackAndFreeString(DSSProperties(mode, OpenDSS_UnpackString(myPointer)), myPointer, myType, mySize);
    fnSystemYChanged  : OpenDSS_PackInt(SystemYChanged(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnUseAuxCurrents  : OpenDSS_PackInt(UseAuxCurrents(mode, OpenDSS_UnpackInt(myPointer)), myPointer, myType, mySize);
    fnAddInAuxCurrents:
      begin
        AddInAuxCurrents(OpenDSS_UnpackInt(myPointer));
        OpenDSS_PackNone(myType, mySize);
      end;
    fnBuildYMatrixD:
      begin
        BuildYMatrixD(OpenDSS_UnpackInt(myPointer, 0), OpenDSS_UnpackInt(myPointer, 1));
        OpenDSS_PackNone(myType, mySize);
      end;
    fnGetPCInjCurr:
      begin
        GetPCInjCurr;
        OpenDSS_PackNone(myType, mySize);
      end;
    fnGetSourceInjCurrents:
      begin
        GetSourceInjCurrents;
        OpenDSS_PackNone(myType, mySize);
      end;
    fnZeroInjCurr:
      begin
        ZeroInjCurr;
        OpenDSS_PackNone(myType, mySize);
      end;
    fnDSSDisposeString:
      begin
        DSSDisposeString(OpenDSS_UnpackString(myPointer));
        OpenDSS_PackNone(myType, mySize);
      end;
  else
    OpenDSS_PackString('Error, Function not recognized', myPointer, myType, mySize);
  end;
end;

//--------------------------------------------------------------------------------
// Implements the API_docs interface for the DLL
//--------------------------------------------------------------------------------
// APIDocsTable (in APIDocsData.pas.inc, included above) is translated line-for-line
// from DLL/APIDocsData.inc in the VersionC C++ port, itself generated from
// C:/Temp/DLL_doc.md. Not hand-maintained: regenerate both files together if the
// API surface changes.
function API_docs(index: longint): pAnsiChar; cdecl;
begin
  if (index >= Low(APIDocsTable)) and (index <= High(APIDocsTable)) then
    Result := pAnsiChar(AnsiString(APIDocsTable[index]))
  else
    Result := pAnsiChar(AnsiString('-1, no more parameters implemented'));
end;

procedure DSSDisposeString(value: pAnsiChar); cdecl;
begin
  // Intentional no-op - see the interface-section comment above.
end;

end.
