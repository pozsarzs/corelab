{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | commandparser.pas                                                        | }
{ | Command parser class                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit commandparser;
{$MODE OBJFPC}{$H+}
interface
uses
   token;
type
  { TCommandParser }
  TCommandParser = class
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Tokenize(const ALine: string): TTokenList; virtual;
  end;

implementation

{ TCommandParser }

// CREATE TCOMMANDPARSER INSTANCE
constructor TCommandParser.Create;
begin
  inherited Create;
end;

// DESTROY TCOMMANDPARSER INSTANCE
destructor TCommandParser.Destroy;
begin
  inherited Destroy;
end;

// CREATE TOKENS
function TCommandParser.Tokenize(const ALine: string): TTokenList;
var
  CurrentChar, InQuoteChar: Char;
  CurrentTokenStr:          string;
  i, Len:                   Integer;
  InQuote:                  Boolean;
  NewToken:                 TToken;
begin
  // create TTokenList instance
  Result := TTokenList.Create;
  // check length of ALine
  Len := Length(ALine);
  if Len = 0 then exit;
  // set initial values
  CurrentTokenStr := '';
  InQuote := False;
  InQuoteChar := #0;
  // tokenizing
  for i := 1 to Len do
  begin
    CurrentChar := ALine[i];
    // string detection ('...' or "...")
    if InQuote then
    begin
      // end of quote sign
      if CurrentChar = InQuoteChar then
      begin
        InQuote := False;
        InQuoteChar := #0;
      end else CurrentTokenStr := CurrentTokenStr + CurrentChar;
    end else
    begin
      // begin of quote sign
      if (CurrentChar = '''') or (CurrentChar = '"') then
      begin
        InQuote := True;
        InQuoteChar := CurrentChar;
      end else
      // separator detection (#32 or #9)
      if (CurrentChar = #32) or (CurrentChar = #9) then
      begin
        if Length(CurrentTokenStr) > 0 then
        begin
          NewToken := TToken.Create(CurrentTokenStr);
          Result.Add(NewToken);
          CurrentTokenStr := '';
        end;
      end else CurrentTokenStr := CurrentTokenStr + CurrentChar;
    end;
  end;
  // add last token
  if Length(CurrentTokenStr) > 0 then
  begin
    NewToken := TToken.Create(CurrentTokenStr);
    Result.Add(NewToken);
  end;
end;

begin
end.
