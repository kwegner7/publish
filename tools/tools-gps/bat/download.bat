
   @set msn=116
   @echo downloading to MSN %msn% ...
   @echo.

   bash sbc_download %msn% /work/vm_latest
   @pause & exit

:: bash sbc_download %msn% k:/jam/jam-2.5
:: bash sbc_download %msn% k:/transfer
:: bash sbc_download %msn% H:\\work\\VersionManager\\SBC3.1.33

   set dest=h:\work\download
   @rm -rf %dest%
   @mkdir %dest%
   svn export h:\work\sbc %dest%\sbc
   svn export h:\work\utils %dest%\utils
   @bash sbc_download %msn%

@pause & exit

