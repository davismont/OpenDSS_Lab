// OpenDSSC.h : Include file for standard system include files,
// or project specific include files.


#include <stdint.h>
#include <iostream>
#include "ControlElem.h"

// TODO: Reference additional headers your program requires here.
using namespace std;
#ifdef WIN32
#define DSS_DLL __declspec(dllexport)
#else
#define DSS_DLL
#endif

struct TAction
{
	int ActionCode,
		DeviceHandle;
};

typedef TAction* pAction;
	

class TCOMControlProxyObj : public TControlElem 
{
public:
	TList ActionList;
	void ClearActionList();
	bool PopAction();

	TCOMControlProxyObj(DSSClass::TDSSClass* ParClass, const String COMProxyName);
	void DopendingAction(const int Code, int ProxyHdl, int ActorID);
	void Reset(int ActorID);
};

#ifdef __cplusplus
extern "C" {
#endif
	// DSS interface
	DSS_DLL int DSSI(int mode, int arg);
	DSS_DLL char* DSSS(int mode, char* arg);
	DSS_DLL void DSSV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int LinesI(int mode, int arg);
	DSS_DLL double LinesF(int mode, double arg);
	DSS_DLL char* LinesS(int mode, char* arg);
	DSS_DLL void LinesV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL char* DSSPut_Command(char* myCmd);
	DSS_DLL int DSSLoads(int mode, int arg);
	DSS_DLL	double DSSLoadsF(int mode, double arg);
	DSS_DLL char* DSSLoadsS(int mode, char* arg);
	DSS_DLL void DSSLoadsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int CapacitorsI(int mode, int arg);
	DSS_DLL double CapacitorsF(int mode, double arg);
	DSS_DLL char* CapacitorsS(int mode, char* arg);
	DSS_DLL void CapacitorsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int ActiveClassI(int mode, int arg);
	DSS_DLL char* ActiveClassS(int mode, char* arg);
	DSS_DLL void ActiveClassV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int BUSI(int mode, int arg);
	DSS_DLL double BUSF(int mode, double arg);
	DSS_DLL char* BUSS(int mode, char* arg);
	DSS_DLL void BUSV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int CapControlsI(int mode, int arg);
	DSS_DLL double CapControlsF(int mode, double arg);
	DSS_DLL char* CapControlsS(int mode, char* arg);
	DSS_DLL void CapControlsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int CircuitI(int mode, int arg);
	DSS_DLL double CircuitF(int mode, double arg1, double arg2);
	DSS_DLL char* CircuitS(int mode, char* arg);
	DSS_DLL void CircuitV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int CktElementI(int mode, int arg);
	DSS_DLL double CktElementF(int mode, double arg);
	DSS_DLL char* CktElementS(int mode, char* arg);
	DSS_DLL void CktElementV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL double CmathLibF(int mode, double arg1, double arg2);
	DSS_DLL void CmathLibV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int GeneratorsI(int mode, int arg);
	DSS_DLL double GeneratorsF(int mode, double arg);
	DSS_DLL char* GeneratorsS(int mode, char* arg);
	DSS_DLL void GeneratorsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int DSSElementI(int mode, int arg);
	DSS_DLL char* DSSElementS(int mode, char* arg);
	DSS_DLL void DSSElementV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL	int DSSProgressI(int mode, int arg);
	DSS_DLL char* DSSProgressS(int mode, char* arg);

	//**************************************************************************************************

	DSS_DLL int DSSExecutiveI(int mode, int arg);
	DSS_DLL char* DSSExecutiveS(int mode, char* arg);

	//**************************************************************************************************

	DSS_DLL int __cdecl ErrorCode();
	DSS_DLL char* __cdecl ErrorDesc();

	//**************************************************************************************************

	DSS_DLL int FusesI(int mode, int arg);
	DSS_DLL double FusesF(int mode, double arg);
	DSS_DLL char* FusesS(int mode, char* arg);
	DSS_DLL void FusesV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int GICSourcesI(int mode, int arg);
	DSS_DLL double GICSourcesF(int mode, double arg);
	DSS_DLL char* GICSourcesS(int mode, char* arg);
	DSS_DLL void GICSourcesV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int IsourceI(int mode, int arg);
	DSS_DLL double IsourceF(int mode, double arg);
	DSS_DLL char* IsourceS(int mode, char* arg);
	DSS_DLL void IsourceV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int LineCodesI(int mode, int arg);
	DSS_DLL double LineCodesF(int mode, double arg);
	DSS_DLL char* LineCodesS(int mode, char* arg);
	DSS_DLL void LineCodesV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int LoadShapeI(int mode, int arg);
	DSS_DLL double LoadShapeF(int mode, double arg);
	DSS_DLL char* LoadShapeS(int mode, char* arg);
	DSS_DLL void LoadShapeV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int MetersI(int mode, int arg);
	DSS_DLL double MetersF(int mode, double arg);
	DSS_DLL char* MetersS(int mode, char* arg);
	DSS_DLL void MetersV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int MonitorsI(int mode, int arg);
	DSS_DLL char* MonitorsS(int mode, char* arg);
	DSS_DLL void MonitorsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int ParallelI(int mode, int arg);
	DSS_DLL void ParallelV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int ParserI(int mode, int arg);
	DSS_DLL double ParserF(int mode, double arg);
	DSS_DLL char* ParserS(int mode, char* arg);
	DSS_DLL void ParserV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int PDElementsI(int mode, int arg);
	DSS_DLL double PDElementsF(int mode, double arg);
	DSS_DLL char* PDElementsS(int mode, char* arg);

	//**************************************************************************************************

	DSS_DLL int PVsystemsI(int mode, int arg);
	DSS_DLL double PVsystemsF(int mode, double arg);
	DSS_DLL char* PVsystemsS(int mode, char* arg);
	DSS_DLL void PVsystemsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int ReactorsI(int mode, int arg);
    DSS_DLL double ReactorsF(int mode, double arg);
    DSS_DLL char* ReactorsS(int mode, char* arg);
    DSS_DLL void ReactorsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

    //**************************************************************************************************

	DSS_DLL int ReclosersI(int mode, int arg);
	DSS_DLL double ReclosersF(int mode, double arg);
	DSS_DLL char* ReclosersS(int mode, char* arg);
	DSS_DLL void ReclosersV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int ReduceCktI(int mode, int arg);
	DSS_DLL double ReduceCktF(int mode, double arg);
	DSS_DLL char* ReduceCktS(int mode, char* arg);

	//**************************************************************************************************

	DSS_DLL int RegControlsI(int mode, int arg);
	DSS_DLL double RegControlsF(int mode, double arg);
	DSS_DLL char* RegControlsS(int mode, char* arg);
	DSS_DLL void RegControlsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int RelaysI(int mode, int arg);
	DSS_DLL char* RelaysS(int mode, char* arg);
	DSS_DLL void RelaysV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int SensorsI(int mode, int arg);
	DSS_DLL double SensorsF(int mode, double arg);
	DSS_DLL char* SensorsS(int mode, char* arg);
	DSS_DLL void SensorsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int SettingsI(int mode, int arg);
	DSS_DLL double SettingsF(int mode, double arg);
	DSS_DLL char* SettingsS(int mode, char* arg);
	DSS_DLL void SettingsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int SolutionI(int mode, int arg);
	DSS_DLL double SolutionF(int mode, double arg);
	DSS_DLL char* SolutionS(int mode, char* arg);
	DSS_DLL void SolutionV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

    DSS_DLL int StoragesI(int mode, int arg);
    DSS_DLL double StoragesF(int mode, double arg);
    DSS_DLL char* StoragesS(int mode, char* arg);
    DSS_DLL void StoragesV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int SwtControlsI(int mode, int arg);
	DSS_DLL double SwtControlsF(int mode, double arg);
	DSS_DLL char* SwtControlsS(int mode, char* arg);
	DSS_DLL void SwtControlsV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int TopologyI(int mode, int arg);
	DSS_DLL char* TopologyS(int mode, char* arg);
	DSS_DLL void TopologyV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int TransformersI(int mode, int arg);
	DSS_DLL double TransformersF(int mode, double arg);
	DSS_DLL char* TransformersS(int mode, char* arg);
	DSS_DLL void TransformersV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int VsourcesI(int mode, int arg);
	DSS_DLL double VsourcesF(int mode, double arg);
	DSS_DLL char* VsourcesS(int mode, char* arg);
	DSS_DLL void VsourcesV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

    DSS_DLL int WindGensI(int mode, int arg);
    DSS_DLL double WindGensF(int mode, double arg);
    DSS_DLL char* WindGensS(int mode, char* arg);
    DSS_DLL void WindGensV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int XYCurvesI(int mode, int arg);
	DSS_DLL double XYCurvesF(int mode, double arg);
	DSS_DLL char* XYCurvesS(int mode, char* arg);
	DSS_DLL void XYCurvesV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL int CtrlQueueI(int mode, int arg);
	DSS_DLL void CtrlQueueV(int mode, uintptr_t* myPtr, int* myType, int* mySize);

	//**************************************************************************************************

	DSS_DLL char* DSSProperties(int mode, char* arg);

	//**************************************************************************************************
	// Unified interface
	//
	// A single entry point that multiplexes every interface function declared above.
	//
	// Function = FunctionBase * 1000 + mode
	//   FunctionBase selects which of the interface functions above gets called (see
	//   TOpenDSSFunctionBase below); mode is passed straight through as the "mode" argument
	//   of that function. Entries that don't take a "mode" (e.g. DSSPut_Command, ErrorCode,
	//   GetPCInjCurr) ignore it, so Function == FunctionBase * 1000 for those.
	//
	// Pointer/Type/Size is an in/out triple, following exactly the convention already used
	// by the *V() functions (see WindGensV for reference):
	//   - On entry, *Pointer must hold the address of a buffer holding whatever argument the
	//     selected function expects: one int, one double, two doubles, a null-terminated
	//     string, or is unused (functions with no argument still expect a valid *Pointer,
	//     its contents are simply ignored). *Type/*Size describe that incoming buffer using
	//     the same codes documented for the *V() functions:
	//       0 - Boolean, 1 - Integer, 2 - double, 3 - Complex (array of doubles), 4 - String
	//   - On return, OpenDSS() overwrites *Pointer/*Type/*Size to describe the outgoing
	//     result using that same convention (functions returning void report Size = 0).
	//   - For FunctionBase values ending in "V" (fnDSSV, fnLinesV, ...), Pointer/Type/Size
	//     are simply forwarded to the underlying *V() function unchanged.
	//
	// Excluded from this dispatcher: InitAndGetYparams, GetCompressedYMatrix, SolveSystem,
	// getIpointer, getVpointer. Their arguments are raw handles/pointer-to-pointer outputs
	// (e.g. multiple simultaneous array pointers) that don't fit the single (Type, Size)
	// value description above, so they remain direct exports only.
	enum TOpenDSSFunctionBase
	{
		fnDSSI = 0,
		fnDSSS = 1,
		fnDSSV = 2,
		fnLinesI = 3,
		fnLinesF = 4,
		fnLinesS = 5,
		fnLinesV = 6,
		fnDSSPutCommand = 7,
		fnDSSLoadsI = 8,
		fnDSSLoadsF = 9,
		fnDSSLoadsS = 10,
		fnDSSLoadsV = 11,
		fnCapacitorsI = 12,
		fnCapacitorsF = 13,
		fnCapacitorsS = 14,
		fnCapacitorsV = 15,
		fnActiveClassI = 16,
		fnActiveClassS = 17,
		fnActiveClassV = 18,
		fnBUSI = 19,
		fnBUSF = 20,
		fnBUSS = 21,
		fnBUSV = 22,
		fnCapControlsI = 23,
		fnCapControlsF = 24,
		fnCapControlsS = 25,
		fnCapControlsV = 26,
		fnCircuitI = 27,
		fnCircuitF = 28,			// takes two doubles (arg1, arg2)
		fnCircuitS = 29,
		fnCircuitV = 30,
		fnCktElementI = 31,
		fnCktElementF = 32,
		fnCktElementS = 33,
		fnCktElementV = 34,
		fnCmathLibF = 35,			// takes two doubles (arg1, arg2)
		fnCmathLibV = 36,
		fnGeneratorsI = 37,
		fnGeneratorsF = 38,
		fnGeneratorsS = 39,
		fnGeneratorsV = 40,
		fnDSSElementI = 41,
		fnDSSElementS = 42,
		fnDSSElementV = 43,
		fnDSSProgressI = 44,
		fnDSSProgressS = 45,
		fnDSSExecutiveI = 46,
		fnDSSExecutiveS = 47,
		fnErrorCode = 48,
		fnErrorDesc = 49,
		fnFusesI = 50,
		fnFusesF = 51,
		fnFusesS = 52,
		fnFusesV = 53,
		fnGICSourcesI = 54,
		fnGICSourcesF = 55,
		fnGICSourcesS = 56,
		fnGICSourcesV = 57,
		fnIsourceI = 58,
		fnIsourceF = 59,
		fnIsourceS = 60,
		fnIsourceV = 61,
		fnLineCodesI = 62,
		fnLineCodesF = 63,
		fnLineCodesS = 64,
		fnLineCodesV = 65,
		fnLoadShapeI = 66,
		fnLoadShapeF = 67,
		fnLoadShapeS = 68,
		fnLoadShapeV = 69,
		fnMetersI = 70,
		fnMetersF = 71,
		fnMetersS = 72,
		fnMetersV = 73,
		fnMonitorsI = 74,
		fnMonitorsS = 75,
		fnMonitorsV = 76,
		fnParallelI = 77,
		fnParallelV = 78,
		fnParserI = 79,
		fnParserF = 80,
		fnParserS = 81,
		fnParserV = 82,
		fnPDElementsI = 83,
		fnPDElementsF = 84,
		fnPDElementsS = 85,
		fnPVsystemsI = 86,
		fnPVsystemsF = 87,
		fnPVsystemsS = 88,
		fnPVsystemsV = 89,
		fnReactorsI = 90,
		fnReactorsF = 91,
		fnReactorsS = 92,
		fnReactorsV = 93,
		fnReclosersI = 94,
		fnReclosersF = 95,
		fnReclosersS = 96,
		fnReclosersV = 97,
		fnReduceCktI = 98,
		fnReduceCktF = 99,
		fnReduceCktS = 100,
		fnRegControlsI = 101,
		fnRegControlsF = 102,
		fnRegControlsS = 103,
		fnRegControlsV = 104,
		fnRelaysI = 105,
		fnRelaysS = 106,
		fnRelaysV = 107,
		fnSensorsI = 108,
		fnSensorsF = 109,
		fnSensorsS = 110,
		fnSensorsV = 111,
		fnSettingsI = 112,
		fnSettingsF = 113,
		fnSettingsS = 114,
		fnSettingsV = 115,
		fnSolutionI = 116,
		fnSolutionF = 117,
		fnSolutionS = 118,
		fnSolutionV = 119,
		fnStoragesI = 120,
		fnStoragesF = 121,
		fnStoragesS = 122,
		fnStoragesV = 123,
		fnSwtControlsI = 124,
		fnSwtControlsF = 125,
		fnSwtControlsS = 126,
		fnSwtControlsV = 127,
		fnTopologyI = 128,
		fnTopologyS = 129,
		fnTopologyV = 130,
		fnTransformersI = 131,
		fnTransformersF = 132,
		fnTransformersS = 133,
		fnTransformersV = 134,
		fnVsourcesI = 135,
		fnVsourcesF = 136,
		fnVsourcesS = 137,
		fnVsourcesV = 138,
		fnWindGensI = 139,
		fnWindGensF = 140,
		fnWindGensS = 141,
		fnWindGensV = 142,
		fnXYCurvesI = 143,
		fnXYCurvesF = 144,
		fnXYCurvesS = 145,
		fnXYCurvesV = 146,
		fnCtrlQueueI = 147,
		fnCtrlQueueV = 148,
		fnDSSProperties = 149,
		fnSystemYChanged = 150,
		fnUseAuxCurrents = 151,
		fnAddInAuxCurrents = 152,	// takes one int (SType), no mode
		fnBuildYMatrixD = 153,		// takes two ints (BuildOps, AllocateVI), no mode
		fnGetPCInjCurr = 154,		// no argument, no mode
		fnGetSourceInjCurrents = 155,	// no argument, no mode
		fnZeroInjCurr = 156,		// no argument, no mode
		fnDSSDisposeString = 157	// takes the string pointer to dispose, no mode
	};

	DSS_DLL void OpenDSS(int Function, uintptr_t* Pointer, int* Type, int* Size);

	//**************************************************************************************************
	// Use this unified interface’s inline documentation to view all currently supported commands, 
	// including their parameters, descriptions, and underlying function code.

	DSS_DLL char* API_docs(int index);

	//**************************************************************************************************

	DSS_DLL int InitAndGetYparams(uintptr_t* hY, unsignedint* nBus, unsignedint* nNZ);
	DSS_DLL void GetCompressedYMatrix(uintptr_t hY, unsignedint nBus, unsignedint nNz, int** ColPtr, int** RowIdx, Ucomplex::complex** cVals);
	DSS_DLL int SystemYChanged(int mode, int arg);
	DSS_DLL int UseAuxCurrents(int mode, int arg);
	DSS_DLL void AddInAuxCurrents(int SType);
	DSS_DLL void BuildYMatrixD(int BuildOps, int AllocateVI);
	DSS_DLL void GetPCInjCurr(void);
	DSS_DLL void GetSourceInjCurrents(void);
	DSS_DLL void ZeroInjCurr(void);
	DSS_DLL int SolveSystem(Ucomplex::complex** NodeV);
	DSS_DLL void getIpointer(Ucomplex::complex** IvectorPtr);
	DSS_DLL void getVpointer(Ucomplex::complex** VvectorPtr);

	/// DSSDisposeString must be called to dispose the memory used by any string returned by the API,
	/// except for string arrays from the `*V()` variant functions, which use a global buffer.
	DSS_DLL void DSSDisposeString(char* value);

#ifdef __cplusplus
}
#endif
