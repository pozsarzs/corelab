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
   commandcontext, token;
type
  // Abstract command parser class
  TCommandParser = class
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Tokenize(const ALine: string; AContext: TCommandContext): TTokenList; virtual;
  end;

implementation

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

function TCommandParser.Tokenize(const ALine: string; AContext: TCommandContext): TTokenList;
var
  CurrentChar, InQuoteChar: Char;
  CurrentTokenStr:          string;
  i, Len: Integer;
  InQuote:                  Boolean;
  NewToken:                 TToken;
begin
  Result := TTokenList.Create;
  Len := Length(ALine);
  if Len = 0 then exit;

  CurrentTokenStr := '';
  InQuote := False;
  InQuoteChar := #0;

  for i := 1 to Len do
  begin
    CurrentChar := ALine[i];

    if InQuote then
    begin
      // Ha idézőjelben vagyunk, keressük a záró idézőjelt
      if CurrentChar = InQuoteChar then
      begin
        InQuote := False;
        InQuoteChar := #0;
      end
      else
        CurrentTokenStr := CurrentTokenStr + CurrentChar;
    end
    else
    begin
      // Idézőjel kezdete (' vagy ")
      if (CurrentChar = '''') or (CurrentChar = '"') then
      begin
        InQuote := True;
        InQuoteChar := CurrentChar;
      end
      // Szóközök és tabulátorok elválasztóként működnek
      else if (CurrentChar = ' ') or (CurrentChar = #9) then
      begin
        if Length(CurrentTokenStr) > 0 then
        begin
          // Itt hívható meg a változó-behelyettesítés:
          // CurrentTokenStr := AContext.ExpandVariables(CurrentTokenStr);
          
          NewToken := TToken.Create(CurrentTokenStr);
          Result.Add(NewToken);
          CurrentTokenStr := '';
        end;
      end
      else
        CurrentTokenStr := CurrentTokenStr + CurrentChar;
    end;
  end;

  // A sor végén maradt utolsó token hozzáadása
  if Length(CurrentTokenStr) > 0 then
  begin
    NewToken := TToken.Create(CurrentTokenStr);
    Result.Add(NewToken);
  end;
end;

begin
end.
