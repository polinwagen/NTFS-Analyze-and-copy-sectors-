unit Unit5;

interface

uses
  Classes,Windows, Messages, SysUtils, Variants,  Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl,ComCtrls, Buttons;

type
  ThrAnalys = class(TThread)
  private
    ExitProcFlag:boolean;
    procedure AnalysCluster;
  protected
    procedure Execute; override;
    destructor Destroy; override;
  end;

implementation
Uses Unit12,Unit11;

procedure ThrAnalys.AnalysCluster;
var
I:integer;
begin

 for I := 0 to num-1  do
    begin
      if ExitProcFlag then exit;
     Form12.Memo2.Lines.Add('ѕоследовательность отрезков дл€ файла:'+select[I]);


      fladr:=(mffrstcl[0]*8*512)+flnum[I]*2*512;


     FillChar(buf1,sizeof(buf1),0);
 if(hDevice<>INVALID_HANDLE_VALUE) then begin
  SetFilePointerEx(hDevice,fladr,nil,FILE_BEGIN);
  bResult:=ReadFile(hDevice,buf1,1024,lpBytesReturned,nil); //читаем атрибут файла
 end;

 attrhead:=$80;

  Form11.Search(); //«агружаем в массив DATA содержимое атрибута DATA

                //раскрываем список отрезков DATA
   offset:=64; // список отрезков начинаетс€ по смещению в атрибуте DATA с позиции 40h

   Form11.UnPack(); // получаем список отрезков атрибута DATA файла
            //cloffs,frstcl,lstcl-кластерное смещение,первыйкластер,последний кластер

      z:=0;

      while cloffs[z]<>0 do
      begin
      flcloffs[I][z]:=cloffs[z];
      flfrstcl[I][z]:=frstcl[z];
      fllstcl[I][z]:=lstcl[z];
      Form12.Memo2.Lines.Add(inttostr(z)+' отрезок = Ќачальный кластер('+inttostr(frstcl[z])+'); '+' ѕоследний кластер('+inttostr(lstcl[z])+');');
      inc(z);
      end;


    end;


ShowMessage('јнализ дл€ '+inttostr(num)+' файлов успешно завершен!');


end;


procedure ThrAnalys.Execute;
begin

 AnalysCluster;
end;

destructor ThrAnalys.Destroy;
begin
 ExitProcFlag:=true;
inherited Destroy;
end;
end.
