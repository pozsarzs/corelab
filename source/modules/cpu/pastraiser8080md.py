import requests
from bs4 import BeautifulSoup
import re

def parse_pastraiser_markdown_shifted():
    url = "https://www.pastraiser.com/cpu/i8080/i8080_opcodes.html"
    
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8',
        'Accept-Language': 'hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7',
        'Connection': 'keep-alive'
    }
    
    try:
        session = requests.Session()
        response = session.get(url, headers=headers, timeout=10)
        response.raise_for_status()
    except Exception as e:
        print(f"Hiba a letöltés során: {e}")
        return

    soup = BeautifulSoup(response.text, 'html.parser')
    table = soup.find('table')
    
    if not table:
        print("Nem található táblázat az oldalon.")
        return

    rows = table.find_all('tr')
    
    # Összegyűjtjük a potenciális adatsorokat (fejléccel együtt, ami szintén legalább 17 cellás)
    valid_rows = []
    for row in rows:
        tds = row.find_all('td')
        if len(tds) >= 17:
            valid_rows.append(tds)

    print("| Opcode | Mnemonic | NumOperand | Op1 Type | Op1 Name | Op2 Type | Op2 Name | AffectedFlags |")
    print("| :---: | :--- | :---: | :---: | :---: | :---: | :---: | :--- |")

    # 17 sort dolgozunk fel: az 1 db fejlécet + a 16 db adatsort
    for r_idx in range(min(17, len(valid_rows))):
        cols = valid_rows[r_idx]
        op_cols = cols[1:17]
        
        # A logikád alapján: a 0. sor a fejléc, az 1. sortól (ami a valódi első adatsor) indítjuk a 0x00-s számozást
        # Az r_idx == 0 esetén negatív tartományba esne, így azt fixen 0x00-nak vagy egy dummy értéknek jelöljük, 
        # mivel ezt a sort úgyis kézzel törlöd majd ki.
        actual_row_idx = r_idx - 1
        
        for c_idx in range(16):
            # Ha a fejléc sorban vagyunk, kapjon egy ideiglenes negatív/fiktív opkódot, a többinél a normál eltolt számozást
            if actual_row_idx < 0:
                opcode = 0x00 
            else:
                opcode = (actual_row_idx << 4) | c_idx
                
            cell = op_cols[c_idx]
            
            mnemonic = "-"
            num_operand = 0
            op1_type, op1_name = "opNone", "-"
            op2_type, op2_name = "opNone", "-"
            flags_found = []
            
            cell_strings = [s.strip() for s in cell.strings if s.strip()]
            
            if cell_strings and cell_strings[0] != '-':
                mnemonic = cell_strings[0]
                
                args_part = ""
                if len(cell_strings) > 1 and not cell_strings[1].isdigit():
                    args_part = cell_strings[1]
                
                for s in cell_strings:
                    if all(c in 'ZSPCA' for c in s) and len(s) <= 5 and not s.isdigit():
                        if 'S' in s: flags_found.append('FLAG_S')
                        if 'Z' in s: flags_found.append('FLAG_Z')
                        if 'P' in s: flags_found.append('FLAG_P')
                        if 'A' in s: flags_found.append('FLAG_AC')
                        if 'C' in s: flags_found.append('FLAG_C')

                if args_part:
                    args = args_part.split(',')
                    
                    if len(args) > 0:
                        arg1 = args[0].strip()
                        if arg1 in ['d8', 'p8']:
                            num_operand = max(num_operand, 1)
                            op1_type = "opImm8"
                            op1_name = "-"
                        elif arg1 in ['d16', 'a16']:
                            num_operand = max(num_operand, 2)
                            op1_type = "opImm16"
                            op1_name = "-"
                        else:
                            op1_type = "opFixed"
                            op1_name = arg1
                            
                    if len(args) > 1:
                        arg2 = args[1].strip()
                        if arg2 in ['d8', 'p8']:
                            num_operand = max(num_operand, 1)
                            op2_type = "opImm8"
                            op2_name = "-"
                        elif arg2 in ['d16', 'a16']:
                            num_operand = max(num_operand, 2)
                            op2_type = "opImm16"
                            op2_name = "-"
                        else:
                            op2_type = "opFixed"
                            op2_name = arg2
            
            if opcode == 0x00 and actual_row_idx == 0:
                mnemonic = "NOP"
                
            flags_str = " or ".join(flags_found) if flags_found else "0"
            
            # Ha a fejléc sorban vagyunk, megjelöljük a sor elejét a könnyebb kézi törléshez
            prefix = "DELETE_ME_HEAD -> " if actual_row_idx < 0 else ""
            
            print(f"{prefix}| `0x{opcode:02X}` | **{mnemonic}** | {num_operand} | `{op1_type}` | {op1_name} | `{op2_type}` | {op2_name} | `{flags_str}` |")

if __name__ == "__main__":
    parse_pastraiser_markdown_shifted()