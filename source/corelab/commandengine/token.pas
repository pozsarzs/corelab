{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | token.pas                                                                | }
{ | Token class                                                              | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit token;
{$MODE OBJFPC}{$H+}
interface
uses
   Generics.Collections;
type
  // Token class
  TToken = class
  protected
    FRawText: string;
  public
    constructor Create(const ARawText: string); reintroduce; virtual;
    destructor Destroy; override;
    property RawText: string read FRawText;
  end;
  // TokenList type 
  TTokenList = specialize TObjectList<TToken>;

implementation

// CREATE TTOKEN INSTANCE
constructor TToken.Create(const ARawText: string);
begin
  inherited Create;
  FRawText := ARawText;
end;

// DESTROY TTOKEN INSTANCE
destructor TToken.Destroy;
begin
  inherited Destroy;
end;

begin
end.
