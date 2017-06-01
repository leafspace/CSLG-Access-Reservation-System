

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 6.00.0361 */
/* at Tue Sep 04 11:22:16 2007
 */
/* Compiler settings for _WComm_Serial.idl:
    Oicf, W1, Zp8, env=Win32 (32b run)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#pragma warning( disable: 4049 )  /* more than 64k source lines */


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef ___WComm_Serial_h__
#define ___WComm_Serial_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __IWComm_Serial_FWD_DEFINED__
#define __IWComm_Serial_FWD_DEFINED__
typedef interface IWComm_Serial IWComm_Serial;
#endif 	/* __IWComm_Serial_FWD_DEFINED__ */


#ifndef __CWComm_Serial_FWD_DEFINED__
#define __CWComm_Serial_FWD_DEFINED__

#ifdef __cplusplus
typedef class CWComm_Serial CWComm_Serial;
#else
typedef struct CWComm_Serial CWComm_Serial;
#endif /* __cplusplus */

#endif 	/* __CWComm_Serial_FWD_DEFINED__ */


/* header files for imported files */
#include "prsht.h"
#include "mshtml.h"
#include "mshtmhst.h"
#include "exdisp.h"
#include "objsafe.h"

#ifdef __cplusplus
extern "C"{
#endif 

void * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void * ); 

#ifndef __IWComm_Serial_INTERFACE_DEFINED__
#define __IWComm_Serial_INTERFACE_DEFINED__

/* interface IWComm_Serial */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IWComm_Serial;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("17EAC671-8B4E-47f6-90E0-1CC210B77502")
    IWComm_Serial : public IDispatch
    {
    public:
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE serial_comm( 
            /* [in] */ BSTR bstrCommand,
            /* [in] */ BSTR bstrPort,
            /* [retval][out] */ BSTR *pbstrInfo) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ErrCode( 
            /* [retval][out] */ LONG *pVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IWComm_SerialVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IWComm_Serial * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IWComm_Serial * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IWComm_Serial * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IWComm_Serial * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IWComm_Serial * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IWComm_Serial * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IWComm_Serial * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *serial_comm )( 
            IWComm_Serial * This,
            /* [in] */ BSTR bstrCommand,
            /* [in] */ BSTR bstrPort,
            /* [retval][out] */ BSTR *pbstrInfo);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrCode )( 
            IWComm_Serial * This,
            /* [retval][out] */ LONG *pVal);
        
        END_INTERFACE
    } IWComm_SerialVtbl;

    interface IWComm_Serial
    {
        CONST_VTBL struct IWComm_SerialVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IWComm_Serial_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IWComm_Serial_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IWComm_Serial_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IWComm_Serial_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define IWComm_Serial_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define IWComm_Serial_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define IWComm_Serial_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define IWComm_Serial_serial_comm(This,bstrCommand,bstrPort,pbstrInfo)	\
    (This)->lpVtbl -> serial_comm(This,bstrCommand,bstrPort,pbstrInfo)

#define IWComm_Serial_get_ErrCode(This,pVal)	\
    (This)->lpVtbl -> get_ErrCode(This,pVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IWComm_Serial_serial_comm_Proxy( 
    IWComm_Serial * This,
    /* [in] */ BSTR bstrCommand,
    /* [in] */ BSTR bstrPort,
    /* [retval][out] */ BSTR *pbstrInfo);


void __RPC_STUB IWComm_Serial_serial_comm_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IWComm_Serial_get_ErrCode_Proxy( 
    IWComm_Serial * This,
    /* [retval][out] */ LONG *pVal);


void __RPC_STUB IWComm_Serial_get_ErrCode_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IWComm_Serial_INTERFACE_DEFINED__ */



#ifndef __WComm_Serial_LIBRARY_DEFINED__
#define __WComm_Serial_LIBRARY_DEFINED__

/* library WComm_Serial */
/* [helpstring][uuid][version] */ 


EXTERN_C const IID LIBID_WComm_Serial;

EXTERN_C const CLSID CLSID_CWComm_Serial;

#ifdef __cplusplus

class DECLSPEC_UUID("02C29D61-0A60-42b4-B2D6-1B2F2F32D212")
CWComm_Serial;
#endif
#endif /* __WComm_Serial_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long *, unsigned long            , BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserMarshal(  unsigned long *, unsigned char *, BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserUnmarshal(unsigned long *, unsigned char *, BSTR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long *, BSTR * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


