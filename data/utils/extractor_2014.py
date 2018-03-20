import csv, mmap

def build_info():
    return {
        'inep_code': 0,
        'year': 2014,
        'rooms_available': 0,
        'rooms_in_use': 0,
        'teachers': 0,
        'masters': 0,
        'doctors': 0,
        'students': 0,
        'classes': 0,
        'senior_teachers': 0,
        'senior_masters': 0,
        'senior_doctors': 0,
        'senior_students': 0,
        'senior_classes': 0,
        'fourth_teachers': 0,
        'fourth_masters': 0,
        'fourth_doctors': 0,
        'fourth_students': 0,
        'fourth_classes': 0,
    }

def mmap_csv(file):
    mm = mmap.mmap(file.fileno(), 0, prot=mmap.PROT_READ)
    for line in iter(mm.readline, b''):
        yield line.decode('iso-8859-1')
    mm.close()

def process_schools_2014(filename):
    print(filename)
    schools = {}
    with open(filename, "r+b") as file:
        reader = csv.DictReader(mmap_csv(file), delimiter='|')
        for i, line in enumerate(reader):
            if ((i + 1) % 10000 == 0):
                print ("Parsed %d schools" % (i + 1))
            school = schools[line['PK_COD_ENTIDADE']] = build_info()
            school['inep_code'] = int(line['PK_COD_ENTIDADE'])
            school['rooms_available'] = int(line['NUM_SALAS_EXISTENTES'] or 0)
            school['rooms_in_use'] = int(line['NUM_SALAS_UTILIZADAS'] or 0)
    return schools

def process_classes_2014(filename, schools):
    print(filename)
    seen = {}
    with open(filename, "r+b") as file:
        reader = csv.DictReader(mmap_csv(file), delimiter='|')
        for i, line in enumerate(reader):
            if ((i + 1) % 10000 == 0):
                print ("Parsed %d classes" % (i + 1))

            school = schools[line['PK_COD_ENTIDADE']]

            if line['FK_COD_TIPO_TURMA'] in ['4', '5']:
                continue

            if line['FK_COD_ETAPA_ENSINO'] in [
                '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36',
                '37', '38']:
                school['classes'] += 1

            if line['FK_COD_ETAPA_ENSINO'] in ['27', '32', '37']:
                school['senior_classes'] += 1

            if line['FK_COD_ETAPA_ENSINO'] in ['28', '33', '38']:
                school['fourth_classes'] += 1

def process_enrollments_2014(filenames, schools):
    for filename in filenames:
        print(filename)
        seen = {}
        with open(filename, 'r+b') as file:
            reader = csv.DictReader(mmap_csv(file), delimiter='|')
            for i, line in enumerate(reader):
                if ((i + 1) % 10000 == 0):
                    print ("Parsed %d enrollments" % (i + 1))

                if line['FK_COD_ETAPA_ENSINO'] not in [
                    '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36',
                    '37', '38']:
                    continue

                if line['FK_COD_TIPO_TURMA'] in ['4', '5']:
                    continue

                if line['FK_COD_MOD_ENSINO'] != '1':
                    continue

                school = schools[line['PK_COD_ENTIDADE']]

                school_code = line['PK_COD_ENTIDADE']

                if school_code not in seen:
                    seen[school_code] = {}

                student_code = line['FK_COD_ALUNO']
                step = line['FK_COD_ETAPA_ENSINO']

                if student_code not in seen[school_code]:
                    seen[school_code][student_code] = set()
                    school['students'] += 1

                if step not in seen[school_code][student_code]:
                    if step in ['27', '32', '37'] and len(set(['27', '32', '37']) & seen[school_code][student_code]) == 0:
                        school['senior_students'] += 1

                    if step in ['28', '33', '38'] and len(set(['28', '33', '38']) & seen[school_code][student_code]) == 0:
                        school['fourth_students'] += 1

                    seen[school_code][student_code].add(step)

def process_teachers_2014(filenames, schools):
    for filename in filenames:
        print(filename)
        seen = {}
        with open(filename, 'r+b') as file:
            reader = csv.DictReader(mmap_csv(file), delimiter='|')
            for i, line in enumerate(reader):
                if ((i + 1) % 10000 == 0):
                    print ("Parsed %d teachers" % (i + 1))

                if line['FK_COD_ETAPA_ENSINO'] not in [
                    '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36',
                    '37', '38']:
                    continue

                if line['FK_COD_MOD_ENSINO'] != '1':
                    continue

                if line['FK_COD_TIPO_TURMA'] in ['4', '5']:
                    continue

                if line ['ID_TIPO_DOCENTE'] not in ['1', '5']:
                    continue

                school = schools[line['PK_COD_ENTIDADE']]

                school_code = line['PK_COD_ENTIDADE']

                if school_code not in seen:
                    seen[school_code] = {}

                teacher_code = line['FK_COD_DOCENTE']
                step = line['FK_COD_ETAPA_ENSINO']

                if teacher_code not in seen[school_code]:
                    seen[school_code][teacher_code] = set()
                    school['teachers'] += 1

                    if line['ID_DOUTORADO'] == '1':
                        school['doctors'] += 1

                    if line['ID_MESTRADO'] == '1':
                        school['masters'] += 1

                if step not in seen[school_code][teacher_code]:
                    if step in ['27', '32', '37'] and len(set(['27', '32', '37']) & seen[school_code][teacher_code]) == 0:
                        school['senior_teachers'] += 1

                        if line['ID_DOUTORADO'] == '1':
                            school['senior_doctors'] += 1

                        if line['ID_MESTRADO'] == '1':
                            school['senior_masters'] += 1

                    if step in ['28', '33', '38'] and len(set(['28', '33', '38']) & seen[school_code][teacher_code]) == 0:
                        school['fourth_teachers'] += 1

                        if line['ID_DOUTORADO'] == '1':
                            school['fourth_doctors'] += 1

                        if line['ID_MESTRADO'] == '1':
                            school['fourth_masters'] += 1

                    seen[school_code][teacher_code].add(step)

def write_schools(schools):
    print("Writing")
    with open('school_statistics_2014.csv', 'w') as file:
        writer = csv.DictWriter(file, list(build_info().keys()))
        writer.writeheader()
        for school in schools.values():
            writer.writerow(school)

schools = process_schools_2014('../Downloads/2014/DADOS/ESCOLAS.CSV')
process_teachers_2014(
    [
        '../Downloads/2014/DADOS/DOCENTES_CO.CSV',
        '../Downloads/2014/DADOS/DOCENTES_SUL.CSV',
        '../Downloads/2014/DADOS/DOCENTES_SUDESTE.CSV',
        '../Downloads/2014/DADOS/DOCENTES_NORDESTE.CSV',
        '../Downloads/2014/DADOS/DOCENTES_NORTE.CSV'
    ],
    schools
)
process_classes_2014('../Downloads/2014/DADOS/TURMAS.CSV', schools)
process_enrollments_2014(
    [
        '../Downloads/2014/DADOS/MATRICULA_CO.CSV',
        '../Downloads/2014/DADOS/MATRICULA_SUL.CSV',
        '../Downloads/2014/DADOS/MATRICULA_SUDESTE.CSV',
        '../Downloads/2014/DADOS/MATRICULA_NORDESTE.CSV',
        '../Downloads/2014/DADOS/MATRICULA_NORTE.CSV'
    ],
    schools
)
write_schools(schools)
