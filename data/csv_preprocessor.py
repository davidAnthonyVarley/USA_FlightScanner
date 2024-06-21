import io

lines = [line.split(',') for line in open('flights_sample.csv').read().strip().split('\n')[1:]]

def int_to_bytes(num: int, w: int):
    result = b''
    while num > 0:
        result = bytes([num % 128]) + result
        num //= 128
    return result.rjust(w, b'\0')

def is_leap(year: int):
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)

def month_start(year: int, month: int):
    month_days = [31, 28 + int(is_leap(year)), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    return sum(month_days[:month - 1])

def year_start(year: int):
    year -= 1
    leap_years = year // 4 - year // 100 + year // 400
    return 365 * year + leap_years

def fmt_date(date: str):
    month, day, year = [int(part) for part in date.split(' ')[0].split('/')]
    days = year_start(year) + month_start(year, month) + day - 1
    return int_to_bytes(days, 3)

def fmt_int(integer: str):
    try:
        return int_to_bytes(int(integer), 1)
    except:
        return int_to_bytes(0x7fff_ffff, 1)

def fmt_time(time: str):
    try:
        return int_to_bytes(int(time[:2]) * 60 + int(time[2:]), 2)
    except:
        return int_to_bytes(1500, 2)

def fmt_float(num: str):
    try:
        return int_to_bytes(int(float(num)), 1)
    except:
        return int_to_bytes(0x7fff_ffff, 1)

def fmt_bool(boolean: str):
    return b'1' if boolean.startswith('1') else b'0'

def fmt_text(text: str):
    return text.encode()


states = [
    "AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN",
    "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH",
    "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TT", "TX",
    "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"
]

def fmt_state(code: str):
    return int_to_bytes(states.index(code), 1)


lines.sort(key=lambda line: fmt_date(line[0]))

output = io.BytesIO()
for line in lines:
    output.write(fmt_date(line[0]))
    output.write(fmt_text(line[1]) + bytes([255]))
    output.write(fmt_int(line[2]) + bytes([255]))
    output.write(fmt_text(line[3]) + bytes([255]))
    output.write(fmt_text(line[4][1:] + ',' + line[5][:-1])+ bytes([255]))
    output.write(fmt_state(line[6]))
    output.write(fmt_text(line[8]) + bytes([255]))
    output.write(fmt_text(line[9][1:] + ',' + line[10][:-1]) + bytes([255]))
    output.write(fmt_state(line[11]))
    output.write(fmt_time(line[13]))
    output.write(fmt_time(line[14]))
    output.write(fmt_time(line[15]))
    output.write(fmt_time(line[16]))
    output.write(fmt_bool(line[17]))
    output.write(fmt_bool(line[18]))
    output.write(fmt_float(line[19])+ bytes([255]))

with open('flights_lines.txt', mode='wb') as file:
    data = output.getvalue()
    file.write(int_to_bytes(len(data), 5))
    file.write(int_to_bytes(len(lines), 5))
    file.write(data)
