import csv
from collections import deque

def fast_csv_reader(filename, delimiter=',', encoding='iso-8859-1'):
    def accessor(key):
        return contents[keys[key]]

    with open(filename, 'r', encoding=encoding, newline="\n") as stream:
        fields = list(map(lambda t: t.strip(), next(stream).split(delimiter)))
        keys = dict(zip(fields, range(len(fields))))
        for line in stream:
            contents = line.split(delimiter)
            yield accessor, contents

def load_missing_schools():
    missing = set()
    for accessor, _ in fast_csv_reader('./missing_schools.csv'):
        code = int(accessor('school_code'))
        missing.add(code)

    return set(filter(lambda c: c < 98000000, missing))

def status_mapping(value):
    if value == '1':
        return 'active'
    if value == '2':
        return 'inactive'
    if value == '3' or value == '4':
        return 'extinct'
    raise 'Invalid status {}'.format(value)

def dependency_mapping(value):
    if value == '1':
        return 'federal'
    if value == '2':
        return 'state'
    if value == '3':
        return 'city'
    if value == '4':
        return 'private'
    raise 'Invalid dependency {}'.format(value)

def location_mapping(value):
    if value == '1':
        return 'urban'
    if value == '2':
        return 'rural'
    raise 'Invalid location {}'.format(value)

def build_school_object_v2(accessor):
    return {
        'inep_code': int(accessor('CO_ENTIDADE')),
        'inep_name': accessor('NO_ENTIDADE'),
        'name': accessor('NO_ENTIDADE').title(),
        'city_ibge_code': int(accessor('CO_MUNICIPIO')),
        'dependency': dependency_mapping(accessor('TP_DEPENDENCIA')),
        'location': location_mapping(accessor('TP_LOCALIZACAO')),
        'status': status_mapping(accessor('TP_SITUACAO_FUNCIONAMENTO'))
    }

def build_school_object_v1(accessor):
    return {
        'inep_code': int(accessor('PK_COD_ENTIDADE')),
        'inep_name': accessor('NO_ENTIDADE'),
        'name': accessor('NO_ENTIDADE').title(),
        'city_ibge_code': int(accessor('FK_COD_MUNICIPIO')),
        'dependency': dependency_mapping(accessor('ID_DEPENDENCIA_ADM')),
        'location': location_mapping(accessor('ID_LOCALIZACAO')),
        'status': status_mapping(accessor('DESC_SITUACAO_FUNCIONAMENTO'))
    }

def scan_schools_2016(extracted, missing):
    extracted_codes = set()
    for accessor, contents in fast_csv_reader('../Downloads/micro_censo_escolar_2016/DADOS/ESCOLAS.CSV', delimiter='|'):
        code = int(accessor('CO_ENTIDADE'))
        if code in missing:
            extracted_codes.add(code)
            built = build_school_object_v2(accessor)
            extracted.append(built)
    return missing - extracted_codes

def scan_schools_2015(extracted, missing):
    extracted_codes = set()
    for accessor, contents in fast_csv_reader('../Downloads/2015/DADOS/ESCOLAS.CSV', delimiter='|'):
        code = int(accessor('CO_ENTIDADE'))
        if code in missing:
            extracted_codes.add(code)
            built = build_school_object_v2(accessor)
            extracted.append(built)
    return missing - extracted_codes

def scan_schools_2014(extracted, missing):
    extracted_codes = set()
    for accessor, contents in fast_csv_reader('../Downloads/2014/DADOS/ESCOLAS.CSV', delimiter='|'):
        code = int(accessor('PK_COD_ENTIDADE'))
        if code in missing:
            extracted_codes.add(code)
            built = build_school_object_v1(accessor)
            extracted.append(built)
    return missing - extracted_codes

def scan_schools_2013(extracted, missing):
    extracted_codes = set()
    for accessor, contents in fast_csv_reader('../Downloads/2013/DADOS/ESCOLAS.CSV', delimiter='|'):
        code = int(accessor('PK_COD_ENTIDADE'))
        if code in missing:
            extracted_codes.add(code)
            built = build_school_object_v1(accessor)
            extracted.append(built)
    return missing - extracted_codes

def scan_schools_2012(extracted, missing):
    extracted_codes = set()
    for accessor, contents in fast_csv_reader('../Downloads/2012/DADOS/ESCOLAS.CSV', delimiter='|'):
        code = int(accessor('PK_COD_ENTIDADE'))
        if code in missing:
            extracted_codes.add(code)
            built = build_school_object_v1(accessor)
            extracted.append(built)
    return missing - extracted_codes

def scan_schools_2011(extracted, missing):
    extracted_codes = set()
    for accessor, contents in fast_csv_reader('../Downloads/2011/DADOS/ESCOLAS.CSV', delimiter='|'):
        code = int(accessor('PK_COD_ENTIDADE'))
        if code in missing:
            extracted_codes.add(code)
            built = build_school_object_v1(accessor)
            extracted.append(built)
    return missing - extracted_codes

def scan_schools_2010(extracted, missing):
    extracted_codes = set()
    for accessor, contents in fast_csv_reader('../Downloads/2010/DADOS/ESCOLAS.CSV', delimiter='|'):
        code = int(accessor('PK_COD_ENTIDADE'))
        if code in missing:
            extracted_codes.add(code)
            built = build_school_object_v1(accessor)
            extracted.append(built)
    return missing - extracted_codes

extracted = deque()
missing = load_missing_schools()
print(len(missing))

missing = scan_schools_2016(extracted, missing)
print(len(missing))

missing = scan_schools_2015(extracted, missing)
print(len(missing))

missing = scan_schools_2014(extracted, missing)
print(len(missing))

missing = scan_schools_2013(extracted, missing)
print(len(missing))

missing = scan_schools_2012(extracted, missing)
print(len(missing))

missing = scan_schools_2011(extracted, missing)
print(len(missing))

missing = scan_schools_2010(extracted, missing)
print(len(missing))

print('Writing')

with open('found_schools.csv', 'w', newline='') as f:
    writer = csv.DictWriter(f, ['inep_code', 'inep_name', 'name', 'city_ibge_code', 'dependency', 'location', 'status'])
    writer.writeheader()
    for school in extracted:
        writer.writerow(school)
