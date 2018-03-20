import csv
from collections import deque, namedtuple

def fast_csv_reader(filename, delimiter=',', encoding='iso-8859-1'):
    def accessor(*lookup):
        return list(map(lambda key: contents[keys[key]], lookup))

    with open(filename, 'r', encoding=encoding, newline="\n") as stream:
        fields = list(map(lambda t: t.replace('"', '').strip(), next(stream).split(delimiter)))
        keys = dict(zip(fields, range(len(fields))))
        for line in stream:
            contents = line.replace('"', '').split(delimiter)
            yield accessor, contents

def schooling_2016(value):
    values = {
        'A': 'no_degree',
        'B': 'no_degree',
        'C': 'first_elementary',
        'D': 'second_elementary',
        'E': 'highschool',
        'F': 'undergraduate',
        'G': 'graduate',
        'H': 'unknown'
    }

    return values[value]

def residents_2016(value):
    return int(value)

def family_income_2016(value):
    values = {
        'A': 0,
        'B': 440.0,
        'C': 1100.0,
        'D': 3080.0,
        'E': 1980.0,
        'F': 2420.0,
        'G': 3080.0,
        'H': 3960.0,
        'I': 4840.0,
        'J': 5720.0,
        'K': 6600.0,
        'L': 7480.0,
        'M': 8360.0,
        'N': 9680.0,
        'O': 11880.0,
        'P': 15400.0,
        'Q': 17600.0
    }

    return values[value]

def laboring_status_2016(value):
    values = {
        'A': 0,
        'B': 0,
        'C': 1
    }

    return values[value]

def pursuing_superior_degree_2016(value):
    values = {
        '0': 0,
        '1': 0,
        '2': 0,
        '3': 1,
        '4': 1,
        '5': 1
    }

    return values[value]

def elementary_school_type_2016(value):
    values = {
        'A': 'public',
        'B': 'public',
        'C': 'private',
        'D': 'private',
        'E': 'other',
        'F': 'other',
        'G': 'other',
        'H': 'other'
    }

    return values[value]


def schooling_2015(value):
    values = {
        'A': 'no_degree',
        'B': 'no_degree',
        'C': 'first_elementary',
        'D': 'second_elementary',
        'E': 'highschool',
        'F': 'undergraduate',
        'G': 'graduate',
        'H': 'unknown'
    }

    return values[value]

def residents_2015(value):
    return int(value)

def family_income_2015(value):
    values = {
        'A': 0,
        'B': 394.0,
        'C': 985.0,
        'D': 1377.0,
        'E': 1771.0,
        'F': 2167.0,
        'G': 2758.0,
        'H': 3546.0,
        'I': 4334.0,
        'J': 5122.0,
        'K': 5910.0,
        'L': 6698.0,
        'M': 7486.0,
        'N': 8668.0,
        'O': 10638.0,
        'P': 13790.0,
        'Q': 15760.0
    }

    return values[value]

def laboring_status_2015(value):
    values = {
        'A': 0,
        'B': 0,
        'C': 1
    }

    return values[value]

def pursuing_superior_degree_2015(value):
    values = {
        '0': 0,
        '1': 0,
        '2': 0,
        '3': 1,
        '4': 1,
        '5': 1
    }

    return values[value]

def elementary_school_type_2015(value):
    values = {
        'A': 'public',
        'B': 'public',
        'C': 'private',
        'D': 'private',
        'E': 'other',
        'F': 'other',
        'G': 'other',
        'H': 'other'
    }

    return values[value]

def schooling_2014(value):
    values = {
        'A': 'no_degree',
        'B': 'first_elementary',
        'C': 'second_elementary',
        'D': 'second_elementary',
        'E': 'highschool',
        'F': 'highschool',
        'G': 'undergraduate',
        'H': 'graduate',
        'I': 'unknown'
    }

    return values[value]

def residents_2014(value):
    return int(value)

def family_income_2014(value):
    values = {
        'A': 0,
        'B': 362.0,
        'C': 905.0,
        'D': 1267.0,
        'E': 1629.0,
        'F': 1991.0,
        'G': 2534.0,
        'H': 3258.0,
        'I': 3982.0,
        'J': 4706.0,
        'K': 5430.0,
        'L': 6154.0,
        'M': 6878.0,
        'N': 7964.0,
        'O': 9774.0,
        'P': 12670.0,
        'Q': 14480.0
    }

    return values[value]

def laboring_status_2014(value):
    values = {
        'A': 0,
        'B': 0,
        'C': 1
    }

    return values[value]

def pursuing_superior_degree_2014(value):
    values = {
        '0': 0,
        '1': 0,
        '2': 0,
        '3': 1,
        '4': 1,
        '5': 1
    }

    return values[value]

def elementary_school_type_2014(value):
    values = {
        'A': 'public',
        'B': 'public',
        'C': 'private',
        'D': 'private',
        'E': 'other',
        'F': 'other',
        'G': 'other',
        'H': 'other'
    }

    return values[value]

def schooling_2013(value):
    values = {
        'A': 'no_degree',
        'B': 'first_elementary',
        'C': 'second_elementary',
        'D': 'second_elementary',
        'E': 'highschool',
        'F': 'highschool',
        'G': 'undergraduate',
        'H': 'graduate',
        'I': 'unknown'
    }

    return values[value]

def residents_2013(value):
    return int(value)

def family_income_2013(value):
    values = {
        'A': 0,
        'B': 339.0,
        'C': 847.5,
        'D': 1186.5,
        'E': 1525.5,
        'F': 1864.5,
        'G': 2373.0,
        'H': 3051.0,
        'I': 3729.0,
        'J': 4407.0,
        'K': 5085.0,
        'L': 5763.0,
        'M': 6441.0,
        'N': 7458.0,
        'O': 9153.0,
        'P': 11865.0,
        'Q': 13560.0
    }

    return values[value]

def laboring_status_2013(value):
    values = {
        'A': 0,
        'B': 0,
        'C': 1
    }

    return values[value]

def pursuing_superior_degree_2013(value):
    values = {
        '0': 0,
        '1': 0,
        '2': 0,
        '3': 1,
        '4': 1,
        '5': 1
    }

    return values[value]

def elementary_school_type_2013(value):
    values = {
        'A': 'public',
        'B': 'public',
        'C': 'private',
        'D': 'private',
        'E': 'other',
        'F': 'other',
        'G': 'other',
        'H': 'other'
    }

    return values[value]

def schooling_2012(value):
    values = {
        'A': 'no_degree',
        'B': 'first_elementary',
        'C': 'second_elementary',
        'D': 'second_elementary',
        'E': 'highschool',
        'F': 'highschool',
        'G': 'undergraduate',
        'H': 'graduate',
        'I': 'unknown'
    }

    return values[value]

def residents_2012(value):
    return int(value)

def family_income_2012(value):
    values = {
        'A': 0,
        'B': 311.0,
        'C': 777.5,
        'D': 1088.5,
        'E': 1399.5,
        'F': 1710.5,
        'G': 2177.0,
        'H': 2799.0,
        'I': 3421.0,
        'J': 4043.0,
        'K': 4665.0,
        'L': 5287.0,
        'M': 5909.0,
        'N': 6842.0,
        'O': 8397.0,
        'P': 10885.0,
        'Q': 12440.0
    }

    return values[value]

def laboring_status_2012(value):
    values = {
        'A': 0,
        'B': 0,
        'C': 1
    }

    return values[value]

def pursuing_superior_degree_2012(value):
    values = {
        '0': 0,
        '1': 0,
        '2': 0,
        '3': 1,
        '4': 1,
        '5': 1
    }

    return values[value]

def elementary_school_type_2012(value):
    values = {
        'A': 'public',
        'B': 'public',
        'C': 'private',
        'D': 'private',
        'E': 'other',
        'F': 'other',
        'G': 'other',
        'H': 'other'
    }

    return values[value]

def schooling_2011(value):
    values = {
        'A': 'no_degree',
        'B': 'first_elementary',
        'C': 'second_elementary',
        'D': 'second_elementary',
        'E': 'highschool',
        'F': 'highschool',
        'G': 'undergraduate',
        'H': 'graduate',
        'I': 'unknown'
    }

    return values[value]

def residents_2011(value):
    return int(value)

def family_income_2011(value):
    values = {
        'A': 0,
        'B': 272.5,
        'C': 681.25,
        'D': 953.75,
        'E': 1907.5,
        'F': 3270.0,
        'G': 4632.5,
        'H': 5995.0,
        'I': 7357.5,
        'J': 12262.5,
        'K': 16350.0
    }

    return values[value]

def laboring_status_2011(value):
    values = {
        'A': 0,
        'B': 1
    }

    return values[value]

def pursuing_superior_degree_2011(value):
    values = {
        '0': 0,
        '1': 0,
        '2': 0,
        '3': 1,
        '4': 1,
        '5': 1
    }

    return values[value]

def elementary_school_type_2011(value):
    values = {
        'A': 'public',
        'B': 'public',
        'C': 'private',
        'D': 'private',
        'E': 'other',
        'F': 'other',
        'G': 'other',
        'H': 'other',
        'I': 'other'
    }

    return values[value]

def schooling_2010(value):
    values = {
        'A': 'first_elementary',
        'B': 'second_elementary',
        'C': 'highschool',
        'D': 'undergraduate',
        'E': 'graduate',
        'F': 'graduate',
        'G': 'graduate',
        'H': 'no_degree',
        'I': 'unknown'
    }

    return values[value]

def residents_2010(value):
    values = {
        'A': 2,
        'B': 5.5,
        'C': 9,
        'D': 10,
        'E': 1
    }

    return values[value]

def family_income_2010(value):
    values = {
        'A': 255.0,
        'B': 1020,
        'C': 2025,
        'D': 3795,
        'E': 5355,
        'F': 6930,
        'G': 9945,
        'H': 0
    }

    return values[value]

def laboring_status_2010(value):
    values = {
        'A': 0,
        'B': 1
    }

    return values[value]

def pursuing_superior_degree_2010(value):
    values = {
        '0': 0,
        '1': 0,
        '2': 0,
        '3': 1,
        '4': 1,
        '5': 1
    }

    return values[value]

def elementary_school_type_2010(value):
    values = {
        'A': 'public',
        'B': 'public',
        'C': 'private',
        'D': 'private',
        'E': 'other',
        'F': 'other',
        'G': 'other',
        'H': 'other'
    }

    return values[value]

def schooling_2009(value):
    values = {
        'A': 'no_degree',
        'B': 'first_elementary',
        'C': 'second_elementary',
        'D': 'second_elementary',
        'E': 'highschool',
        'F': 'highschool',
        'G': 'undergraduate',
        'H': 'graduate',
        'I': 'unknown'
    }

    return values[value]

def residents_2009(value):
    values = {
        'A': 2,
        'B': 3,
        'C': 4,
        'D': 5,
        'E': 6,
        'F': 1
    }

    return values[value]

def family_income_2009(value):
    values = {
        'A': 232.5,
        'B': 697.5,
        'C': 1627.5,
        'D': 3487.5,
        'E': 9300.0,
        'F': 18600.0,
        'G': 23250.0,
        'H': 5995.0,
        'I': 7357.5,
        'J': 12262.5,
        'K': 16350.0
    }

    return values[value]

def laboring_status_2009(value):
    values = {
        'A': 1,
        'B': 1,
        'C': 1,
        'D': 0,
        'E': 0,
        'F': 0
    }

    return values[value]

def pursuing_superior_degree_2009(value):
    values = {
        'A': 0,
        'B': 1,
        'C': 0,
        'D': 0,
        'E': 0,
        'F': 0
    }

    return values[value]

def elementary_school_type_2009(value):
    values = {
        'A': 'public',
        'B': 'private',
        'C': 'private',
        'D': 'other',
        'E': 'other',
        'F': 'other',
        'G': 'other'
    }

    return values[value]

Answer = namedtuple('Answer', [
    'father_schooling', 'mother_schooling', 'residents', 'monthly_income', 'is_laboring',
    'pursuing_superior_degree', 'elementary_school_type', 'school_code'])

def parse_answers_2016(filepath):
    answers = deque()
    reader = fast_csv_reader(filepath, delimiter=';')
    for accessor, _ in reader:
        raw = accessor(
            'CO_ESCOLA', 'Q001', 'Q002', 'Q005', 'Q006', 'Q026', 'Q035', 'Q036', 'Q042')

        if '' in raw:
            continue

        answer = Answer(
            school_code=int(raw[0]),
            father_schooling=schooling_2016(raw[1]),
            mother_schooling=schooling_2016(raw[2]),
            residents=residents_2016(raw[3]),
            monthly_income=family_income_2016(raw[4]),
            is_laboring=laboring_status_2016(raw[5]),
            pursuing_superior_degree=(
                pursuing_superior_degree_2016(raw[6]) or
                pursuing_superior_degree_2016(raw[7])),
            elementary_school_type=elementary_school_type_2016(raw[8])
        )
        answers.append(answer)

    return answers

def parse_answers_2015(filepath):
    answers = deque()
    reader = fast_csv_reader(filepath)
    for accessor, _ in reader:
        raw = accessor(
            'CO_ESCOLA', 'Q001', 'Q002', 'Q005', 'Q006', 'Q026', 'Q035', 'Q036', 'Q042')

        if '' in raw:
            continue

        answer = Answer(
            school_code=int(raw[0]),
            father_schooling=schooling_2015(raw[1]),
            mother_schooling=schooling_2015(raw[2]),
            residents=residents_2015(raw[3]),
            monthly_income=family_income_2015(raw[4]),
            is_laboring=laboring_status_2015(raw[5]),
            pursuing_superior_degree=(
                pursuing_superior_degree_2015(raw[6]) or
                pursuing_superior_degree_2015(raw[7])),
            elementary_school_type=elementary_school_type_2015(raw[8])
        )
        answers.append(answer)

    return answers

def parse_answers_2014(filepath):
    answers = deque()
    reader = fast_csv_reader(filepath)
    for accessor, _ in reader:
        raw = accessor(
            'COD_ESCOLA', 'Q001', 'Q002', 'Q004', 'Q003', 'Q022', 'Q026', 'Q027', 'Q032')

        if '' in raw:
            continue

        answer = Answer(
            school_code=int(raw[0]),
            father_schooling=schooling_2014(raw[1]),
            mother_schooling=schooling_2014(raw[2]),
            residents=residents_2014(raw[3]),
            monthly_income=family_income_2014(raw[4]),
            is_laboring=laboring_status_2014(raw[5]),
            pursuing_superior_degree=(
                pursuing_superior_degree_2014(raw[6]) or
                pursuing_superior_degree_2014(raw[7])),
            elementary_school_type=elementary_school_type_2014(raw[8])
        )
        answers.append(answer)

    return answers

def parse_answers_2013(filepath):
    answers = deque()
    reader = fast_csv_reader(filepath, delimiter=';')
    for accessor, _ in reader:
        raw = accessor(
            'COD_ESCOLA', 'Q001', 'Q002', 'Q004', 'Q003', 'Q022', 'Q026', 'Q027', 'Q032')

        if '' in raw:
            continue

        answer = Answer(
            school_code=int(raw[0]),
            father_schooling=schooling_2013(raw[1]),
            mother_schooling=schooling_2013(raw[2]),
            residents=residents_2013(raw[3]),
            monthly_income=family_income_2013(raw[4]),
            is_laboring=laboring_status_2013(raw[5]),
            pursuing_superior_degree=(
                pursuing_superior_degree_2013(raw[6]) or
                pursuing_superior_degree_2013(raw[7])),
            elementary_school_type=elementary_school_type_2013(raw[8])
        )
        answers.append(answer)

    return answers

def parse_registrations_2012(filepath):
    registrations = {}
    reader = fast_csv_reader(filepath)
    for accessor, _ in reader:
        raw = accessor('NU_INSCRICAO', 'PK_COD_ENTIDADE')

        if '' in raw or '.' in raw:
            continue

        registrations[int(raw[0])] = int(raw[1])

    return registrations

def parse_answers_2012(filepath, registrations):
    answers = deque()
    reader = fast_csv_reader(filepath)
    for accessor, _ in reader:
        raw = accessor(
            'NU_INSCRICAO', 'Q01', 'Q02', 'Q04', 'Q03', 'Q22', 'Q26', 'Q27', 'Q32')

        if '' in raw or '.' in raw:
            continue

        registration = int(raw[0])
        if registration not in registrations:
            continue
        school_code = registrations[registration]

        answer = Answer(
            school_code=school_code,
            father_schooling=schooling_2012(raw[1]),
            mother_schooling=schooling_2012(raw[2]),
            residents=residents_2012(raw[3]),
            monthly_income=family_income_2012(raw[4]),
            is_laboring=laboring_status_2012(raw[5]),
            pursuing_superior_degree=(
                pursuing_superior_degree_2012(raw[6]) or
                pursuing_superior_degree_2012(raw[7])),
            elementary_school_type=elementary_school_type_2012(raw[8])
        )
        answers.append(answer)

    return answers

def parse_registrations_2011(filepath):
    registrations = {}
    with open(filepath, 'r', encoding='iso-8859-1') as stream:
        for line in stream:
            registration = line[0:12].strip()
            school_code = line[203:211].strip()
            raw = [registration, school_code]

            if '' in raw or '.' in raw:
                continue

            registrations[int(registration)] = int(school_code)

    return registrations

def parse_answers_2011(filepath, registrations):
    answers = deque()
    with open(filepath, 'r', encoding='iso-8859-1') as stream:
        for line in stream:
            registration = line[0:12].strip()
            q02 = line[15].strip()
            q03 = line[16].strip()
            q01 = line[13:15].strip()
            q04 = line[17].strip()
            q08 = line[21].strip()
            q25 = line[39].strip()
            q30 = line[44].strip()

            raw = [registration, q02, q03, q01, q04, q08, q25, q30]

            if '' in raw or '.' in raw:
                continue

            registration = int(raw[0])
            if registration not in registrations:
                continue
            school_code = registrations[registration]

            answer = Answer(
                school_code=school_code,
                father_schooling=schooling_2011(raw[1]),
                mother_schooling=schooling_2011(raw[2]),
                residents=residents_2011(raw[3]),
                monthly_income=family_income_2011(raw[4]),
                is_laboring=laboring_status_2011(raw[5]),
                pursuing_superior_degree=pursuing_superior_degree_2011(raw[6]),
                elementary_school_type=elementary_school_type_2011(raw[7])
            )
            answers.append(answer)

    return answers

def parse_registrations_2010(filepath):
    registrations = {}
    with open(filepath, 'r', encoding='iso-8859-1') as stream:
        for line in stream:
            registration = line[0:12].strip()
            school_code = line[203:211].strip()
            raw = [registration, school_code]

            if '' in raw or '.' in raw:
                continue

            registrations[int(registration)] = int(school_code)

    return registrations

def parse_answers_2010(filepath, registrations):
    answers = deque()
    with open(filepath, 'r', encoding='iso-8859-1') as stream:
        for line in stream:
            if len(line) < 43:
                continue

            registration = line[0:12].strip()
            q02 = line[14].strip()
            q03 = line[15].strip()
            q01 = line[13].strip()
            q04 = line[16].strip()
            q08 = line[20].strip()
            q25 = line[37].strip()
            q30 = line[42].strip()

            raw = [registration, q02, q03, q01, q04, q08, q25, q30]

            if '' in raw or '.' in raw:
                continue

            registration = int(raw[0])
            if registration not in registrations:
                continue
            school_code = registrations[registration]

            answer = Answer(
                school_code=school_code,
                father_schooling=schooling_2010(raw[1]),
                mother_schooling=schooling_2010(raw[2]),
                residents=residents_2010(raw[3]),
                monthly_income=family_income_2010(raw[4]),
                is_laboring=laboring_status_2010(raw[5]),
                pursuing_superior_degree=pursuing_superior_degree_2010(raw[6]),
                elementary_school_type=elementary_school_type_2010(raw[7])
            )
            answers.append(answer)

    return answers

def parse_registrations_2009(filepath):
    registrations = {}
    with open(filepath, 'r', encoding='iso-8859-1') as stream:
        for line in stream:
            registration = line[0:12].strip()
            school_code = line[190:198].strip()
            raw = [registration, school_code]

            if '' in raw or '.' in raw or '*' in raw:
                continue

            registrations[int(registration)] = int(school_code)

    return registrations

def parse_answers_2009(filepath, registrations):
    answers = deque()
    with open(filepath, 'r', encoding='iso-8859-1') as stream:
        for line in stream:
            if len(line) < 86:
                continue

            registration = line[0:12].strip()
            q17 = line[29].strip()
            q18 = line[30].strip()
            q15 = line[27].strip()
            q21 = line[33].strip()
            q42 = line[54].strip()
            q40 = line[52].strip()
            q73 = line[85].strip()

            raw = [registration, q17, q18, q15, q21, q42, q40, q73]

            if '' in raw or '.' in raw or '*' in raw:
                continue

            registration = int(raw[0])
            if registration not in registrations:
                continue
            school_code = registrations[registration]

            answer = Answer(
                school_code=school_code,
                father_schooling=schooling_2009(raw[1]),
                mother_schooling=schooling_2009(raw[2]),
                residents=residents_2009(raw[3]),
                monthly_income=family_income_2009(raw[4]),
                is_laboring=laboring_status_2009(raw[5]),
                pursuing_superior_degree=pursuing_superior_degree_2009(raw[6]),
                elementary_school_type=elementary_school_type_2009(raw[7])
            )
            answers.append(answer)

    return answers

def build_school_info(school_code, year):
    return {
        'school_code': school_code,
        'year': year,
        'amount': 0,
        'schooling_first_elementary': 0,
        'schooling_second_elementary': 0,
        'schooling_highschool': 0,
        'schooling_undergraduate': 0,
        'schooling_graduate': 0,
        'schooling_other': 0,
        'residents': 0,
        'family_income': 0.0,
        'laboring': 0,
        'superior_degree': 0,
        'elementary_school_public': 0,
        'elementary_school_private': 0,
        'elementary_school_other': 0
    }

def transform_schooling(schooling):
    values = {
        'first_elementary': 'schooling_first_elementary',
        'second_elementary': 'schooling_second_elementary',
        'highschool': 'schooling_highschool',
        'undergraduate': 'schooling_undergraduate',
        'graduate': 'schooling_graduate',
        'no_degree': 'schooling_other',
        'unknown': 'schooling_other'
    }

    return values[schooling]

def transform_elementary_school_type(type):
    values = {
        'public': 'elementary_school_public',
        'private': 'elementary_school_private',
        'other': 'elementary_school_other'
    }

    return values[type]

def transform(answers, year):
    answers_by_school = {}

    for answer in answers:
        if answer.school_code not in answers_by_school:
            answers_by_school[answer.school_code] = build_school_info(
                answer.school_code, year)

        school = answers_by_school[answer.school_code]
        school['amount'] += 1
        school[transform_schooling(answer.father_schooling)] += 1
        school[transform_schooling(answer.mother_schooling)] += 1
        school['residents'] += answer.residents
        school['family_income'] += answer.monthly_income
        school['laboring'] += answer.is_laboring
        school['superior_degree'] += answer.pursuing_superior_degree
        school[transform_elementary_school_type(answer.elementary_school_type)] += 1

    return answers_by_school

def write_stats(stats, year):
    with open('answers_{}.csv'.format(year), 'w', newline='') as stream:
        keys = list(build_school_info(1, 1).keys())
        writer = csv.DictWriter(stream, keys)
        writer.writeheader()
        for stat in stats.values():
            writer.writerow(stat)

print('Parsing 2016')
answers = parse_answers_2016(
    "/home/alef/Downloads/Microdados_enem_2016/DADOS/microdados_enem_2016.csv")
stats = transform(answers, 2016)
write_stats(stats, 2016)

# print('Parsing 2015')
# answers = parse_answers_2015(
#     '../Downloads/microdados_enem_2015/DADOS/MICRODADOS_ENEM_2015.csv')
# stats = transform(answers, 2015)
# write_stats(stats, 2015)
#
# print('Parsing 2014')
# answers = parse_answers_2014(
#     '../Downloads/microdados_enem2014/DADOS/MICRODADOS_ENEM_2014.csv')
# stats = transform(answers, 2014)
# write_stats(stats, 2014)
#
# print('Parsing 2013')
# answers = parse_answers_2013(
#     '../Downloads/micro_2013/DADOS/MICRODADOS_ENEM_2013.csv')
# stats = transform(answers, 2013)
# write_stats(stats, 2013)
#
# print('Parsing 2012')
# registrations = parse_registrations_2012(
#     '../Downloads/microdados_enem2012/DADOS/DADOS_ENEM_2012.csv')
# answers = parse_answers_2012(
#     '../Downloads/microdados_enem2012/DADOS/QUESTIONARIO_ENEM_2012.csv', registrations)
# stats = transform(answers, 2012)
# write_stats(stats, 2012)
#
# print('Parsing 2011')
# registrations = parse_registrations_2011(
#     '../Downloads/microdados_enem2011/DADOS/DADOS_ENEM_2011.TXT')
# answers = parse_answers_2011(
#     '../Downloads/microdados_enem2011/DADOS/QUESTIONARIO_SOCIO_ECONOMICO_ENEM_2011.TXT',
#     registrations)
# stats = transform(answers, 2011)
# write_stats(stats, 2011)
#
# print('Parsing 2010')
# registrations = parse_registrations_2010(
#     '../Downloads/Microdados ENEM 2010/Dados Enem 2010/DADOS_ENEM_2010.txt')
# answers = parse_answers_2010(
#     '../Downloads/Microdados ENEM 2010/Dados Enem 2010/QUESTIONARIO_SOCIO_ECONOMICO_ENEM'
#     '_2010.txt',
#     registrations)
# stats = transform(answers, 2010)
# write_stats(stats, 2010)
#
# print('Parsing 2009')
# registrations = parse_registrations_2009(
#     '../Downloads/Microdados ENEM 2009/Dados Enem 2009/DADOS_ENEM_2009.txt')
# answers = parse_answers_2009(
#     '../Downloads/Microdados ENEM 2009/Dados Enem 2009/QUESTIONARIO_SOCIO_ECONOMICO_ENEM'
#     '_2009.txt',
#     registrations)
# stats = transform(answers, 2009)
# write_stats(stats, 2009)
