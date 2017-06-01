unit WComm_Serial_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130  $
// File generated on 2007-12-24 12:34:40 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Documents and Settings\wg\×ÀÃæ\wcomm_sdk\V1.0\Bin\WComm_Serial.dll (1)
// LIBID: {0E9CC222-4ECB-4EA6-8B7D-7AEFA07BFCE1}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TCWComm_Serial) : Server C:\Documents and Settings\wg\×ÀÃæ\wcomm_sdk\V1.0\Bin\WComm_Serial.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses ActiveX, Classes, Graphics, OleServer, StdVCL, Variants, Windows;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  WComm_SerialMajorVersion = 1;
  WComm_SerialMinorVersion = 0;

  LIBID_WComm_Serial: TGUID = '{0E9CC222-4ECB-4EA6-8B7D-7AEFA07BFCE1}';

  IID_IWComm_Serial: TGUID = '{17EAC671-8B4E-47F6-90E0-1CC210B77502}';
  CLASS_CWComm_Serial: TGUID = '{02C29D61-0A60-42B4-B2D6-1B2F2F32D212}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IWComm_Serial = interface;
  IWComm_SerialDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CWComm_Serial = IWComm_Serial;


// *********************************************************************//
// Interface: IWComm_Serial
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {17EAC671-8B4E-47F6-90E0-1CC210B77502}
// *********************************************************************//
  IWComm_Serial = interface(IDispatch)
    ['{17EAC671-8B4E-47F6-90E0-1CC210B77502}']
    function  serial_comm(const bstrCommand: WideString; const bstrPort: WideString): WideString; safecall;
    function  Get_ErrCode: Integer; safecall;
    property ErrCode: Integer read Get_ErrCode;
  end;

// *********************************************************************//
// DispIntf:  IWComm_SerialDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {17EAC671-8B4E-47F6-90E0-1CC210B77502}
// *********************************************************************//
  IWComm_SerialDisp = dispinterface
    ['{17EAC671-8B4E-47F6-90E0-1CC210B77502}']
    function  serial_comm(const bstrCommand: WideString; const bstrPort: WideString): WideString; dispid 1;
    property ErrCode: Integer readonly dispid 3;
  end;

// *********************************************************************//
// The Class CoCWComm_Serial provides a Create and CreateRemote method to          
// create instances of the default interface IWComm_Serial exposed by              
// the CoClass CWComm_Serial. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCWComm_Serial = class
    class function Create: IWComm_Serial;
    class function CreateRemote(const MachineName: string): IWComm_Serial;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCWComm_Serial
// Help String      : WComm Class
// Default Interface: IWComm_Serial
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (1026) CanCreate Aggregatable
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCWComm_SerialProperties= class;
{$ENDIF}
  TCWComm_Serial = class(TOleServer)
  private
    FIntf:        IWComm_Serial;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TCWComm_SerialProperties;
    function      GetServerProperties: TCWComm_SerialProperties;
{$ENDIF}
    function      GetDefaultInterface: IWComm_Serial;
  protected
    procedure InitServerData; override;
    function  Get_ErrCode: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IWComm_Serial);
    procedure Disconnect; override;
    function  serial_comm(const bstrCommand: WideString; const bstrPort: WideString): WideString;
    property  DefaultInterface: IWComm_Serial read GetDefaultInterface;
    property ErrCode: Integer read Get_ErrCode;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCWComm_SerialProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCWComm_Serial
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCWComm_SerialProperties = class(TPersistent)
  private
    FServer:    TCWComm_Serial;
    function    GetDefaultInterface: IWComm_Serial;
    constructor Create(AServer: TCWComm_Serial);
  protected
    function  Get_ErrCode: Integer;
  public
    property DefaultInterface: IWComm_Serial read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'COM+';

implementation

uses ComObj;

class function CoCWComm_Serial.Create: IWComm_Serial;
begin
  Result := CreateComObject(CLASS_CWComm_Serial) as IWComm_Serial;
end;

class function CoCWComm_Serial.CreateRemote(const MachineName: string): IWComm_Serial;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CWComm_Serial) as IWComm_Serial;
end;

procedure TCWComm_Serial.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{02C29D61-0A60-42B4-B2D6-1B2F2F32D212}';
    IntfIID:   '{17EAC671-8B4E-47F6-90E0-1CC210B77502}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCWComm_Serial.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IWComm_Serial;
  end;
end;

procedure TCWComm_Serial.ConnectTo(svrIntf: IWComm_Serial);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCWComm_Serial.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCWComm_Serial.GetDefaultInterface: IWComm_Serial;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCWComm_Serial.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCWComm_SerialProperties.Create(Self);
{$ENDIF}
end;

destructor TCWComm_Serial.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCWComm_Serial.GetServerProperties: TCWComm_SerialProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function  TCWComm_Serial.Get_ErrCode: Integer;
begin
  Result := DefaultInterface.ErrCode;
end;

function  TCWComm_Serial.serial_comm(const bstrCommand: WideString; const bstrPort: WideString): WideString;
begin
  Result := DefaultInterface.serial_comm(bstrCommand, bstrPort);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCWComm_SerialProperties.Create(AServer: TCWComm_Serial);
begin
  inherited Create;
  FServer := AServer;
end;

function TCWComm_SerialProperties.GetDefaultInterface: IWComm_Serial;
begin
  Result := FServer.DefaultInterface;
end;

function  TCWComm_SerialProperties.Get_ErrCode: Integer;
begin
  Result := DefaultInterface.ErrCode;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TCWComm_Serial]);
end;

end.
