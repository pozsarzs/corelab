{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | bcd7seg_7447.pas                                                         | }
{ | BCD to 7 segment decoder (SN7447N-type signs)                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

const
  BCD7seg_7447: array[0..15] of byte = (
    {         GFEDCBA}
    { '0' } %00111111,
    { '1' } %00000110,
    { '2' } %01011011,
    { '3' } %01001111,
    { '4' } %01100110,
    { '5' } %01101101,
    { '6' } %01111101,
    { '7' } %00000111,
    { '8' } %01111111,
    { '9' } %01101111,
    { 'A' } %01011000,
    { 'B' } %01001100,
    { 'C' } %01100010,
    { 'D' } %01101001,
    { 'E' } %01111000,
    { 'F' } %00000000); 
