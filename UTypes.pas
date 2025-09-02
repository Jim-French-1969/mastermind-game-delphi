unit UTypes;

interface

uses
  UConsts, Classes;

type
  TAllowedNums = 1..NUM_COLOURS;
  TCode = array[1..CODE_LENGTH] of integer;
  PCode = ^TCode;

const
  NO_CODE : TCode = (0, 0, 0, 0);

type
  TAllCodes = class
    private
      fCodeList : TList;
      fCodeListPos : integer; // Position in the list 0..Count -1
      function GetTotalCount : integer;

    public
      class function CodeToString(CurCode : TCode) : string;
      function ListDump : string;
      function GetFirst(var Code : TCode) : boolean;
      function GetNext(var Code : TCode) : boolean;
      function GetCurrent(var Code : TCode) : boolean;
      function RemoveCurrent: boolean;
      constructor Create;
      destructor  Destroy; override;

      property ListPos : integer read fCodeListPos;
      property TotalCount : integer read GetTotalCount;
  end;

implementation

uses
  SysUtils;

{ TAllCodes }

constructor TAllCodes.Create;
var
  i, j, k, l : integer;
  CurCode : TCode;
  pCurCode : PCode;
begin
  inherited Create;

  fCodeList := TList.Create;

  for i := 1 to NUM_COLOURS do
    for j := 1 to NUM_COLOURS do
      for k := 1 to NUM_COLOURS do
        for l := 1 to NUM_COLOURS do
        begin
          CurCode[1] := i;
          CurCode[2] := j;
          CurCode[3] := k;
          CurCode[4] := l;
          new(pCurCode);
          pCurCode^ := CurCode;
          fCodeList.Add(pCurCode);
        end;
end;

destructor TAllCodes.Destroy;
var
  i : integer;
  pCurCode : PCode;
begin
  i := 0;
  while i < fCodeList.Count do
  begin
    pCurCode := fCodeList[i];
    dispose(pCurCode);
    inc(i);
  end;
  fCodeList.Free;
  inherited Destroy;
end;

function TAllCodes.GetTotalCount: integer;
begin
  Result := fCodeList.Count;
end;

function TAllCodes.GetFirst(var Code: TCode): boolean;
// Returns : true if there are any elements in fCodeList (and that first element)
//           false otherwise
begin
  fCodeListPos := 0;
  Result := fCodeList.Count > 0;
  if Result then
    Code := TCode(fCodeList[0]^)
  else
    Code := NO_CODE;
end;

function TAllCodes.GetNext(var Code: TCode): boolean;
begin
  inc(fCodeListPos);
  Result := fCodeListPos < fCodeList.Count;

  if Result then
    Code := TCode(fCodeList[fCodeListPos]^)
  else
    Code := NO_CODE;
end;

function TAllCodes.GetCurrent(var Code: TCode): boolean;
begin
  Result := (fCodeListPos >= 0) and (fCodeListPos < fCodeList.Count);
  if Result then
    Code := TCode(fCodeList[fCodeListPos]^)
  else
    Code := NO_CODE;
end;

function TAllCodes.RemoveCurrent : boolean;
var
  CurCode : PCode;
begin
  // Assume if in range this code can be deleted
  Result := (fCodeListPos >= 0) and (fCodeListPos < fCodeList.Count);
  CurCode := fCodeList[fCodeListPos];
  dispose(CurCode);
  fCodeList.Delete(fCodeListPos);
  // As the list is one shorter we have implicitly 'moved on' through the list
  // so fCodeListPos remains the same
end;

class function TAllCodes.CodeToString(CurCode : TCode) : string;
var
  i : integer;
begin
  Result := '';

  for i := 1 to CODE_LENGTH do
    Result := Result + IntToStr(CurCode[i]) + '  ';

  Result := Trim(Result);
end;

function TAllCodes.ListDump : string;
var
  i : integer;
  CurCode : TCode;
begin
  Result := '';
  for i := 0 to fCodeList.Count -1 do
  begin
    CurCode := TCode(fCodeList[i]^);
    Result := Result + CodeToString(CurCode) + CRLF;
  end;
  Result := Trim(Result);
end;

end.
