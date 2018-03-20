import csv, argparse, re

from collections import deque

ALL_FIELDS = [
    "registration",
    "year",
    "consistency",
    "resident_city_code",
    "resident_city_name",
    "resident_state_code",
    "resident_state_name",
    "hospital_unity",
    "training",
    "school_code",
    "school_city_code",
    "school_city_name",
    "school_state_code",
    "school_state_name",
    "school_dependency",
    "school_location",
    "school_status",
    "age",
    "gender",
    "nationality",
    "birth_city_code",
    "birth_city_name",
    "birth_state_code",
    "birth_state_name",
    "conclusion",
    "conclusion_year",
    "school_type",
    "conclusion_type",
    "marital_status",
    "color",
    "low_vision",
    "blind",
    "deaf",
    "hearing_deficiency",
    "blind_deaf",
    "physical_disability",
    "mental_disability",
    "attention_deficit",
    "dyslexia",
    "pregnancy",
    "lactating",
    "elderly",
    "dyscalculia",
    "autism",
    "monocular_vision",
    "sabbatista",
    "other_deficiency",
    "resource",
    "social_name",
    "braille",
    "enlarged_big",
    "enlarged_medium",
    "reader",
    "easy_access",
    "transcription",
    "hand_talk",
    "lip_reading",
    "wheelchair",
    "separated_chair",
    "leg_support",
    "interpret_guide",
    "litter",
    "computer",
    "special_chair",
    "left_handed_chair",
    "padded_chair",
    "lying",
    "obese_furniture",
    "overlay_blade",
    "hearing_protector",
    "glucose_meter",
    "braille_machine",
    "soroban",
    "pacemaker",
    "probe",
    "medicine",
    "individual_room",
    "special_room",
    "companion_room",
    "specific_forniture",
    "specific_material",
    "other_necessity",
    "prison_unity",
    "certification",
    "certifier_name",
    "certifier_state_code",
    "certifier_state_name",
    "test_city_code",
    "test_city_name",
    "test_state_code",
    "test_state_name",
    "cn_presence",
    "ch_presence",
    "lc_presence",
    "mt_presence",
    "cn_test_code",
    "ch_test_code",
    "lc_test_code",
    "mt_test_code",
    "cn_score",
    "ch_score",
    "lc_score",
    "mt_score",
    "cn_answers",
    "ch_answers",
    "lc_answers",
    "mt_answers",
    "lc_type",
    "cn_key",
    "ch_key",
    "lc_key",
    "mt_key",
    "essay_status",
    "first_competence_score",
    "second_competence_score",
    "third_competence_score",
    "fourth_competence_score",
    "fifth_competence_score",
    "essay_score"]

ALL_FIELDS_INDICES = dict(map(lambda v: (v[1], v[0]), enumerate(ALL_FIELDS)))

def mappings_2016():
    def dependency_enum(value):
        mapping = { 1: "federal", 2: "state", 3: "city", 4: "private" }
        return mapping[value]

    def location_enum(value):
        mapping = { 1: "urban", 2: "rural" }
        return mapping[value]

    def status_enum(value):
        mapping = { 1: "active", 2: "inactive", 3: "extinct", 4: "extinct" }
        return mapping[value]

    def gender_enum(value):
        mapping = { "M": "male", "F": "female" }
        return mapping[value]

    def nationality_enum(value):
        mapping = { 0: None, 1: "natural", 2: "naturalized", 3: "foreign", 4: "abroad" }
        return mapping[value]

    def conclusion_enum(value):
        mapping = { 1: "completed", 2: "current", 3: "future", 4: "incomplete" }
        return mapping[value]

    def conclusion_year(value):
        if value == 0:
            return None
        if value == 10:
            return 0
        return 2017 - value

    def school_enum(value):
        mapping = { 1: None, 2: "public", 3: "private", 4: "foreign" }
        return mapping[value]

    def conclusion_type_enum(value):
        mapping = { 1: "regular", 2: "special", 3: "youth" }
        return mapping[value]

    def marital_enum(value):
        mapping = { 0: "single", 1: "married", 2: "divorced", 3: "widower" }
        return mapping[value]

    def color_enum(value):
        mapping = {
            0: None,
            1: "white",
            2: "black",
            3: "brown",
            4: "yellow",
            5: "indigene",
            6: "unkown" }
        return mapping[value]

    def resource_enum(value):
        mapping = { 0: 1, 1: 0 }
        return mapping[value]

    def presence_enum(value):
        mapping = { 0: "missed", 1: "present", 2: "eliminated" }
        return mapping[value]

    def lc_enum(value):
        mapping = { 0: "english", 1: "spanish" }
        return mapping[value]

    def essay_enum(value):
        mapping = {
            1: "ok",
            2: "nullified",
            3: "copy",
            4: "empty",
            5: "hurt",
            6: "escape",
            7: "incorrect",
            8: "insufficient",
            9: "disconnected",
            98: "other" }
        return mapping[value]

    def filter_answers(answers):
        return re.sub(r"[^A-E]", "*", answers)

    mappings = {
        "registration"           : ["NU_INSCRICAO", int],
        "year"                   : ["NU_ANO", int],
        "resident_city_code"     : ["CO_MUNICIPIO_RESIDENCIA", int],
        "resident_city_name"     : ["NO_MUNICIPIO_RESIDENCIA"],
        "resident_state_code"    : ["CO_UF_RESIDENCIA", int],
        "resident_state_name"    : ["SG_UF_RESIDENCIA"],
        "hospital_unity"         : ["IN_ESTUDA_CLASSE_HOSPITALAR", int],
        "training"               : ["IN_TREINEIRO", int],
        "school_code"            : ["CO_ESCOLA", int],
        "school_city_code"       : ["CO_MUNICIPIO_ESC", int],
        "school_city_name"       : ["NO_MUNICIPIO_ESC"],
        "school_state_code"      : ["CO_UF_ESC", int],
        "school_state_name"      : ["SG_UF_ESC"],
        "school_dependency"      : ["TP_DEPENDENCIA_ADM_ESC", int, dependency_enum],
        "school_location"        : ["TP_LOCALIZACAO_ESC", int, location_enum],
        "school_status"          : ["TP_SIT_FUNC_ESC", int, status_enum],
        "age"                    : ["NU_IDADE", int],
        "gender"                 : ["TP_SEXO", gender_enum],
        "nationality"            : ["TP_NACIONALIDADE", int, nationality_enum],
        "birth_city_code"        : ["CO_MUNICIPIO_NASCIMENTO", int],
        "birth_city_name"        : ["NO_MUNICIPIO_NASCIMENTO"],
        "birth_state_code"       : ["CO_UF_NASCIMENTO", int],
        "birth_state_name"       : ["SG_UF_NASCIMENTO"],
        "conclusion"             : ["TP_ST_CONCLUSAO", int, conclusion_enum],
        "conclusion_year"        : ["TP_ANO_CONCLUIU", int, conclusion_year],
        "school_type"            : ["TP_ESCOLA", int, school_enum],
        "conclusion_type"        : ["TP_ENSINO", int, conclusion_type_enum],
        "marital_status"         : ["TP_ESTADO_CIVIL", int, marital_enum],
        "color"                  : ["TP_COR_RACA", int, color_enum],
        "low_vision"             : ["IN_BAIXA_VISAO", int],
        "blind"                  : ["IN_CEGUEIRA", int],
        "deaf"                   : ["IN_SURDEZ", int],
        "hearing_deficiency"     : ["IN_DEFICIENCIA_AUDITIVA", int],
        "blind_deaf"             : ["IN_SURDO_CEGUEIRA", int],
        "physical_disability"    : ["IN_DEFICIENCIA_FISICA", int],
        "mental_disability"      : ["IN_DEFICIENCIA_MENTAL", int],
        "attention_deficit"      : ["IN_DEFICIT_ATENCAO", int],
        "dyslexia"               : ["IN_DISLEXIA", int],
        "pregnancy"              : ["IN_GESTANTE", int],
        "lactating"              : ["IN_LACTANTE", int],
        "elderly"                : ["IN_IDOSO", int],
        "dyscalculia"            : ["IN_DISCALCULIA", int],
        "autism"                 : ["IN_AUTISMO", int],
        "monocular_vision"       : ["IN_VISAO_MONOCULAR", int],
        "sabbatista"             : ["IN_SABATISTA", int],
        "other_deficiency"       : ["IN_OUTRA_DEF", int],
        "resource"               : ["IN_SEM_RECURSO", int, resource_enum],
        "social_name"            : ["IN_NOME_SOCIAL", int],
        "braille"                : ["IN_BRAILLE", int],
        "enlarged_big"           : ["IN_AMPLIADA_24", int],
        "enlarged_medium"        : ["IN_AMPLIADA_18", int],
        "reader"                 : ["IN_LEDOR", int],
        "easy_access"            : ["IN_ACESSO", int],
        "transcription"          : ["IN_TRANSCRICAO", int],
        "hand_talk"              : ["IN_LIBRAS", int],
        "lip_reading"            : ["IN_LEITURA_LABIAL", int],
        "wheelchair"             : ["IN_MESA_CADEIRA_RODAS", int],
        "separated_chair"        : ["IN_MESA_CADEIRA_SEPARADA", int],
        "leg_support"            : ["IN_APOIO_PERNA", int],
        "interpret_guide"        : ["IN_GUIA_INTERPRETE", int],
        "litter"                 : ["IN_MACA", int],
        "computer"               : ["IN_COMPUTADOR", int],
        "special_chair"          : ["IN_CADEIRA_ESPECIAL", int],
        "left_handed_chair"      : ["IN_CADEIRA_CANHOTO", int],
        "padded_chair"           : ["IN_CADEIRA_ACOLCHOADA", int],
        "lying"                  : ["IN_PROVA_DEITADO", int],
        "obese_furniture"        : ["IN_MOBILIARIO_OBESO", int],
        "overlay_blade"          : ["IN_LAMINA_OVERLAY", int],
        "hearing_protector"      : ["IN_PROTETOR_AURICULAR", int],
        "glucose_meter"          : ["IN_MEDIDOR_GLICOSE", int],
        "braille_machine"        : ["IN_MAQUINA_BRAILE", int],
        "soroban"                : ["IN_SOROBAN", int],
        "pacemaker"              : ["IN_MARCA_PASSO", int],
        "probe"                  : ["IN_SONDA", int],
        "medicine"               : ["IN_MEDICAMENTOS", int],
        "individual_room"        : ["IN_SALA_INDIVIDUAL", int],
        "special_room"           : ["IN_SALA_ESPECIAL", int],
        "companion_room"         : ["IN_SALA_ACOMPANHANTE", int],
        "specific_forniture"     : ["IN_MOBILIARIO_ESPECIFICO", int],
        "specific_material"      : ["IN_MATERIAL_ESPECIFICO", int],
        "certification"          : ["IN_CERTIFICADO", int],
        "certifier_name"         : ["NO_ENTIDADE_CERTIFICACAO"],
        "certifier_state_code"   : ["CO_UF_ENTIDADE_CERTIFICACAO", int],
        "certifier_state_name"   : ["SG_UF_ENTIDADE_CERTIFICACAO"],
        "test_city_code"         : ["CO_MUNICIPIO_PROVA", int],
        "test_city_name"         : ["NO_MUNICIPIO_PROVA"],
        "test_state_code"        : ["CO_UF_PROVA", int],
        "test_state_name"        : ["SG_UF_PROVA"],
        "cn_presence"            : ["TP_PRESENCA_CN", int, presence_enum],
        "ch_presence"            : ["TP_PRESENCA_CH", int, presence_enum],
        "lc_presence"            : ["TP_PRESENCA_LC", int, presence_enum],
        "mt_presence"            : ["TP_PRESENCA_MT", int, presence_enum],
        "cn_test_code"           : ["CO_PROVA_CN", int],
        "ch_test_code"           : ["CO_PROVA_CH", int],
        "lc_test_code"           : ["CO_PROVA_LC", int],
        "mt_test_code"           : ["CO_PROVA_MT", int],
        "cn_score"               : ["NU_NOTA_CN", float],
        "ch_score"               : ["NU_NOTA_CH", float],
        "lc_score"               : ["NU_NOTA_LC", float],
        "mt_score"               : ["NU_NOTA_MT", float],
        "cn_answers"             : ["TX_RESPOSTAS_CN", filter_answers],
        "ch_answers"             : ["TX_RESPOSTAS_CH", filter_answers],
        "lc_answers"             : ["TX_RESPOSTAS_LC", filter_answers],
        "mt_answers"             : ["TX_RESPOSTAS_MT", filter_answers],
        "lc_type"                : ["TP_LINGUA", int, lc_enum],
        "cn_key"                 : ["TX_GABARITO_CN"],
        "ch_key"                 : ["TX_GABARITO_CH"],
        "lc_key"                 : ["TX_GABARITO_LC"],
        "mt_key"                 : ["TX_GABARITO_MT"],
        "essay_status"           : ["TP_STATUS_REDACAO", int, essay_enum],
        "first_competence_score" : ["NU_NOTA_COMP1", float],
        "second_competence_score": ["NU_NOTA_COMP2", float],
        "third_competence_score" : ["NU_NOTA_COMP3", float],
        "fourth_competence_score": ["NU_NOTA_COMP4", float],
        "fifth_competence_score" : ["NU_NOTA_COMP5", float],
        "essay_score"            : ["NU_NOTA_REDACAO", float]
    }

    return mappings

def post_process_2016(transformed):
    cn_presence = transformed[ALL_FIELDS_INDICES["cn_presence"]]
    ch_presence = transformed[ALL_FIELDS_INDICES["ch_presence"]]
    lc_presence = transformed[ALL_FIELDS_INDICES["lc_presence"]]
    mt_presence = transformed[ALL_FIELDS_INDICES["mt_presence"]]

    if cn_presence != "present":
        transformed[ALL_FIELDS_INDICES["cn_answers"]] = None
        transformed[ALL_FIELDS_INDICES["cn_key"]] = None

    if ch_presence != "present":
        transformed[ALL_FIELDS_INDICES["ch_answers"]] = None
        transformed[ALL_FIELDS_INDICES["ch_key"]] = None

    if lc_presence != "present":
        transformed[ALL_FIELDS_INDICES["lc_answers"]] = None
        transformed[ALL_FIELDS_INDICES["lc_key"]] = None
    else:
        lc_key_index = ALL_FIELDS_INDICES["lc_key"]
        lc_answers_index = ALL_FIELDS_INDICES["lc_answers"]
        lc_type = transformed[ALL_FIELDS_INDICES["lc_type"]]
        lc_key = transformed[lc_key_index]
        lc_answers = transformed[lc_answers_index]

        if lc_type == "english":
            answers = lc_answers[0:5] + lc_answers[10:]
            key = lc_key[0:5] + lc_key[10:]
        else:
            answers = lc_answers[5:]
            key = lc_key[5:]

        transformed[lc_answers_index] = answers
        transformed[lc_key_index] = key

    if mt_presence != "present":
        transformed[ALL_FIELDS_INDICES["mt_answers"]] = None
        transformed[ALL_FIELDS_INDICES["mt_key"]] = None

def presets_2015():
    def dependency_enum(value):
        mapping = { 1: "federal", 2: "state", 3: "city", 4: "private" }
        return mapping[value]

    def location_enum(value):
        mapping = { 1: "urban", 2: "rural" }
        return mapping[value]

    def status_enum(value):
        mapping = { 1: "active", 2: "inactive", 3: "extinct", 4: "extinct" }
        return mapping[value]

    def gender_enum(value):
        mapping = { "M": "male", "F": "female" }
        return mapping[value]

    def nationality_enum(value):
        mapping = { 0: None, 1: "natural", 2: "naturalized", 3: "foreign", 4: "abroad" }
        return mapping[value]

    def conclusion_enum(value):
        mapping = { 1: "completed", 2: "current", 3: "future", 4: "incomplete" }
        return mapping[value]

    def conclusion_year(value):
        if value == 0:
            return None
        if value == 10:
            return 0
        return 2016 - value

    def school_enum(value):
        mapping = { 1: None, 2: "public", 3: "private", 4: "foreign" }
        return mapping[value]

    def conclusion_type_enum(value):
        mapping = { 1: "regular", 2: "special", 3: "youth" }
        return mapping[value]

    def marital_enum(value):
        mapping = { 0: "single", 1: "married", 2: "divorced", 3: "widower" }
        return mapping[value]

    def color_enum(value):
        mapping = {
            0: None,
            1: "white",
            2: "black",
            3: "brown",
            4: "yellow",
            5: "indigene",
            6: "unkown" }
        return mapping[value]

    def resource_enum(value):
        mapping = { 0: 1, 1: 0 }
        return mapping[value]

    def presence_enum(value):
        mapping = { 0: "missed", 1: "present", 2: "eliminated" }
        return mapping[value]

    def lc_enum(value):
        mapping = { 0: "english", 1: "spanish" }
        return mapping[value]

    def essay_enum(value):
        mapping = {
            1: "ok",
            2: "nullified",
            3: "copy",
            4: "empty",
            5: "hurt",
            6: "escape",
            7: "incorrect",
            8: "insufficient",
            9: "disconnected",
            98: "other" }
        return mapping[value]

    def filter_answers(answers):
        return re.sub(r"[^A-E]", "*", answers)

    def consistency(consistency_file):
        consistency_table = {}

        print("Loading consistency table")

        with open(consistency_file, "r", newline="", encoding="iso-8859-1") as data:
            reader = csv.DictReader(data)

            for values in reader:
                registration = int(values["NU_INSCRICAO"])
                consistency_table[registration] = {
                    "school_code": int(values["CO_ESCOLA"]),
                    "school_state_code": int(values["CO_UF_ESC"]),
                    "school_dependency":
                        dependency_enum(int(values["TP_DEPENDENCIA_ADM_ESC"])),
                    "school_location": location_enum(int(values["TP_LOCALIZACAO_ESC"]))
                }

        def consistent(transformed, original):
            registration = ALL_FIELDS_INDICES["registration"]
            consistency = ALL_FIELDS_INDICES["consistency"]
            school_code = ALL_FIELDS_INDICES["school_code"]
            school_state_code = ALL_FIELDS_INDICES["school_state_code"]
            school_state_name = ALL_FIELDS_INDICES["school_state_name"]
            school_city_code = ALL_FIELDS_INDICES["school_city_code"]
            school_city_name = ALL_FIELDS_INDICES["school_city_name"]
            school_dependency = ALL_FIELDS_INDICES["school_dependency"]
            school_location = ALL_FIELDS_INDICES["school_location"]
            school_status = ALL_FIELDS_INDICES["school_status"]

            if transformed[registration] in consistency_table:

                registry = consistency_table[transformed[registration]]
                if (transformed[school_code] != registry["school_code"]
                    or transformed[school_state_code] != registry["school_state_code"]
                    or transformed[school_dependency] != registry["school_dependency"]
                    or transformed[school_location] != registry["school_location"]) :

                    transformed[school_code] = registry["school_code"]
                    transformed[school_state_code] = registry["school_state_code"]
                    transformed[school_dependency] = registry["school_dependency"]
                    transformed[school_location] = registry["school_location"]

                    transformed[school_state_name] = None
                    transformed[school_city_code] = None
                    transformed[school_city_name] = None
                    transformed[school_status] = None
                    transformed[consistency] = "overwritten"
                else:
                    transformed[consistency] = "validated"
            else:
                transformed[consistency] = "unpresent"

        return consistent

    mappings = {
        "registration"           : ["NU_INSCRICAO", int],
        "year"                   : ["NU_ANO", int],
        "resident_city_code"     : ["CO_MUNICIPIO_RESIDENCIA", int],
        "resident_city_name"     : ["NO_MUNICIPIO_RESIDENCIA"],
        "resident_state_code"    : ["CO_UF_RESIDENCIA", int],
        "resident_state_name"    : ["SG_UF_RESIDENCIA"],
        "hospital_unity"         : ["IN_ESTUDA_CLASSE_HOSPITALAR", int],
        "training"               : ["IN_TREINEIRO", int],
        "school_code"            : ["CO_ESCOLA", int],
        "school_city_code"       : ["CO_MUNICIPIO_ESC", int],
        "school_city_name"       : ["NO_MUNICIPIO_ESC"],
        "school_state_code"      : ["CO_UF_ESC", int],
        "school_state_name"      : ["SG_UF_ESC"],
        "school_dependency"      : ["TP_DEPENDENCIA_ADM_ESC", int, dependency_enum],
        "school_location"        : ["TP_LOCALIZACAO_ESC", int, location_enum],
        "school_status"          : ["TP_SIT_FUNC_ESC", int, status_enum],
        "age"                    : ["NU_IDADE", int],
        "gender"                 : ["TP_SEXO", gender_enum],
        "nationality"            : ["TP_NACIONALIDADE", int, nationality_enum],
        "birth_city_code"        : ["CO_MUNICIPIO_NASCIMENTO", int],
        "birth_city_name"        : ["NO_MUNICIPIO_NASCIMENTO"],
        "birth_state_code"       : ["CO_UF_NASCIMENTO", int],
        "birth_state_name"       : ["SG_UF_NASCIMENTO"],
        "conclusion"             : ["TP_ST_CONCLUSAO", int, conclusion_enum],
        "conclusion_year"        : ["TP_ANO_CONCLUIU", int, conclusion_year],
        "school_type"            : ["TP_ESCOLA", int, school_enum],
        "conclusion_type"        : ["TP_ENSINO", int, conclusion_type_enum],
        "marital_status"         : ["TP_ESTADO_CIVIL", int, marital_enum],
        "color"                  : ["TP_COR_RACA", int, color_enum],
        "low_vision"             : ["IN_BAIXA_VISAO", int],
        "blind"                  : ["IN_CEGUEIRA", int],
        "deaf"                   : ["IN_SURDEZ", int],
        "hearing_deficiency"     : ["IN_DEFICIENCIA_AUDITIVA", int],
        "blind_deaf"             : ["IN_SURDO_CEGUEIRA", int],
        "physical_disability"    : ["IN_DEFICIENCIA_FISICA", int],
        "mental_disability"      : ["IN_DEFICIENCIA_MENTAL", int],
        "attention_deficit"      : ["IN_DEFICIT_ATENCAO", int],
        "dyslexia"               : ["IN_DISLEXIA", int],
        "pregnancy"              : ["IN_GESTANTE", int],
        "lactating"              : ["IN_LACTANTE", int],
        "elderly"                : ["IN_IDOSO", int],
        "dyscalculia"            : ["IN_DISCALCULIA", int],
        "autism"                 : ["IN_AUTISMO", int],
        "monocular_vision"       : ["IN_VISAO_MONOCULAR", int],
        "sabbatista"             : ["IN_SABATISTA", int],
        "other_deficiency"       : ["IN_OUTRA_DEF", int],
        "resource"               : ["IN_SEM_RECURSO", int, resource_enum],
        "social_name"            : ["IN_NOME_SOCIAL", int],
        "braille"                : ["IN_BRAILLE", int],
        "enlarged_big"           : ["IN_AMPLIADA_24", int],
        "enlarged_medium"        : ["IN_AMPLIADA_18", int],
        "reader"                 : ["IN_LEDOR", int],
        "easy_access"            : ["IN_ACESSO", int],
        "transcription"          : ["IN_TRANSCRICAO", int],
        "hand_talk"              : ["IN_LIBRAS", int],
        "lip_reading"            : ["IN_LEITURA_LABIAL", int],
        "wheelchair"             : ["IN_MESA_CADEIRA_RODAS", int],
        "separated_chair"        : ["IN_MESA_CADEIRA_SEPARADA", int],
        "leg_support"            : ["IN_APOIO_PERNA", int],
        "interpret_guide"        : ["IN_GUIA_INTERPRETE", int],
        "litter"                 : ["IN_MACA", int],
        "computer"               : ["IN_COMPUTADOR", int],
        "special_chair"          : ["IN_CADEIRA_ESPECIAL", int],
        "left_handed_chair"      : ["IN_CADEIRA_CANHOTO", int],
        "padded_chair"           : ["IN_CADEIRA_ACOLCHOADA", int],
        "lying"                  : ["IN_PROVA_DEITADO", int],
        "obese_furniture"        : ["IN_MOBILIARIO_OBESO", int],
        "overlay_blade"          : ["IN_LAMINA_OVERLAY", int],
        "hearing_protector"      : ["IN_PROTETOR_AURICULAR", int],
        "glucose_meter"          : ["IN_MEDIDOR_GLICOSE", int],
        "braille_machine"        : ["IN_MAQUINA_BRAILE", int],
        "soroban"                : ["IN_SOROBAN", int],
        "pacemaker"              : ["IN_MARCA_PASSO", int],
        "probe"                  : ["IN_SONDA", int],
        "medicine"               : ["IN_MEDICAMENTOS", int],
        "individual_room"        : ["IN_SALA_INDIVIDUAL", int],
        "special_room"           : ["IN_SALA_ESPECIAL", int],
        "companion_room"         : ["IN_SALA_ACOMPANHANTE", int],
        "specific_forniture"     : ["IN_MOBILIARIO_ESPECIFICO", int],
        "specific_material"      : ["IN_MATERIAL_ESPECÍFICO", int],
        "certification"          : ["IN_CERTIFICADO", int],
        "certifier_name"         : ["NO_ENTIDADE_CERTIFICACAO"],
        "certifier_state_code"   : ["CO_UF_ENTIDADE_CERTIFICACAO", int],
        "certifier_state_name"   : ["SG_UF_ENTIDADE_CERTIFICACAO"],
        "test_city_code"         : ["CO_MUNICIPIO_PROVA", int],
        "test_city_name"         : ["NO_MUNICIPIO_PROVA"],
        "test_state_code"        : ["CO_UF_PROVA", int],
        "test_state_name"        : ["SG_UF_PROVA"],
        "cn_presence"            : ["TP_PRESENCA_CN", int, presence_enum],
        "ch_presence"            : ["TP_PRESENCA_CH", int, presence_enum],
        "lc_presence"            : ["TP_PRESENCA_LC", int, presence_enum],
        "mt_presence"            : ["TP_PRESENCA_MT", int, presence_enum],
        "cn_test_code"           : ["CO_PROVA_CN", int],
        "ch_test_code"           : ["CO_PROVA_CH", int],
        "lc_test_code"           : ["CO_PROVA_LC", int],
        "mt_test_code"           : ["CO_PROVA_MT", int],
        "cn_score"               : ["NU_NOTA_CN", float],
        "ch_score"               : ["NU_NOTA_CH", float],
        "lc_score"               : ["NU_NOTA_LC", float],
        "mt_score"               : ["NU_NOTA_MT", float],
        "cn_answers"             : ["TX_RESPOSTAS_CN", filter_answers],
        "ch_answers"             : ["TX_RESPOSTAS_CH", filter_answers],
        "lc_answers"             : ["TX_RESPOSTAS_LC", filter_answers],
        "mt_answers"             : ["TX_RESPOSTAS_MT", filter_answers],
        "lc_type"                : ["TP_LINGUA", int, lc_enum],
        "cn_key"                 : ["TX_GABARITO_CN"],
        "ch_key"                 : ["TX_GABARITO_CH"],
        "lc_key"                 : ["TX_GABARITO_LC"],
        "mt_key"                 : ["TX_GABARITO_MT"],
        "essay_status"           : ["TP_STATUS_REDACAO", int, essay_enum],
        "first_competence_score" : ["NU_NOTA_COMP1", float],
        "second_competence_score": ["NU_NOTA_COMP2", float],
        "third_competence_score" : ["NU_NOTA_COMP3", float],
        "fourth_competence_score": ["NU_NOTA_COMP4", float],
        "fifth_competence_score" : ["NU_NOTA_COMP5", float],
        "essay_score"            : ["NU_NOTA_REDACAO", float]
    }

    return (mappings, consistency)

def presets_2014():
    def dependency_enum(value):
        mapping = { 1: "federal", 2: "state", 3: "city", 4: "private" }
        return mapping[value]

    def location_enum(value):
        mapping = { 1: "urban", 2: "rural" }
        return mapping[value]

    def status_enum(value):
        mapping = { 1: "active", 2: "inactive", 3: "extinct", 4: "extinct" }
        return mapping[value]

    def gender_enum(value):
        mapping = { "M": "male", "F": "female" }
        return mapping[value]

    def nationality_enum(value):
        mapping = { 1: "natural", 2: "naturalized", 3: "foreign", 4: "abroad" }
        return mapping[value]

    def conclusion_enum(value):
        mapping = { 1: "completed", 2: "current", 3: "future", 4: "incomplete" }
        return mapping[value]

    def school_enum(value):
        mapping = { 1: "public", 2: "private" }
        return mapping[value]

    def conclusion_type_enum(value):
        mapping = { 1: "regular", 2: "youth", 4: "special" }
        return mapping[value]

    def marital_enum(value):
        mapping = { 0: "single", 1: "married", 2: "divorced", 3: "widower" }
        return mapping[value]

    def color_enum(value):
        mapping = {
            0: None,
            1: "white",
            2: "black",
            3: "brown",
            4: "yellow",
            5: "indigene"}
        return mapping[value]

    def presence_enum(value):
        mapping = { 0: "missed", 1: "present", 2: "eliminated" }
        return mapping[value]

    def lc_enum(value):
        mapping = { 0: "english", 1: "spanish" }
        return mapping[value]

    def essay_enum(value):
        mapping = {
            1: "empty",
            2: "nullified",
            3: "escape",
            4: "incorrect",
            5: "insufficient",
            6: "missed",
            7: "ok",
            9: "hurt",
            10: "copy",
            11: "disconnected"}
        return mapping[value]

    def filter_answers(answers):
        return re.sub(r"[^A-E]", "*", answers)

    def consistency(consistency_file):
        consistency_table = {}

        print("Loading consistency table")

        with open(consistency_file, "r", newline="", encoding="iso-8859-1") as data:
            reader = csv.DictReader(data)

            for values in reader:
                registration = int(values["NU_INSCRICAO"])
                consistency_table[registration] = {
                    "school_code": int(values["COD_ESCOLA"]),
                    "school_state_code": int(values["COD_UF_ESC"]),
                    "school_dependency":
                        dependency_enum(int(values["ID_DEPENDENCIA_ADM_ESC"])),
                    "school_location": location_enum(int(values["ID_LOCALIZACAO_ESC"]))
                }

        def consistent(transformed, original):
            registration = ALL_FIELDS_INDICES["registration"]
            consistency = ALL_FIELDS_INDICES["consistency"]
            school_code = ALL_FIELDS_INDICES["school_code"]
            school_state_code = ALL_FIELDS_INDICES["school_state_code"]
            school_state_name = ALL_FIELDS_INDICES["school_state_name"]
            school_city_code = ALL_FIELDS_INDICES["school_city_code"]
            school_city_name = ALL_FIELDS_INDICES["school_city_name"]
            school_dependency = ALL_FIELDS_INDICES["school_dependency"]
            school_location = ALL_FIELDS_INDICES["school_location"]
            school_status = ALL_FIELDS_INDICES["school_status"]

            if transformed[registration] in consistency_table:

                registry = consistency_table[transformed[registration]]
                if (transformed[school_code] != registry["school_code"]
                    or transformed[school_state_code] != registry["school_state_code"]
                    or transformed[school_dependency] != registry["school_dependency"]
                    or transformed[school_location] != registry["school_location"]) :

                    transformed[school_code] = registry["school_code"]
                    transformed[school_state_code] = registry["school_state_code"]
                    transformed[school_dependency] = registry["school_dependency"]
                    transformed[school_location] = registry["school_location"]

                    transformed[school_state_name] = None
                    transformed[school_city_code] = None
                    transformed[school_city_name] = None
                    transformed[school_status] = None
                    transformed[consistency] = "overwritten"
                else:
                    transformed[consistency] = "validated"
            else:
                transformed[consistency] = "unpresent"

        return consistent

    mappings = {
        "registration"           : ["NU_INSCRICAO", int],
        "year"                   : ["NU_ANO", int],
        "resident_city_code"     : ["COD_MUNICIPIO_RESIDENCIA", int],
        "resident_city_name"     : ["NO_MUNICIPIO_RESIDENCIA"],
        "resident_state_code"    : ["COD_UF_RESIDENCIA", int],
        "resident_state_name"    : ["UF_RESIDENCIA"],
        "hospital_unity"         : ["IN_ESTUDA_CLASSE_HOSPITALAR", int],
        "school_code"            : ["COD_ESCOLA", int],
        "school_city_code"       : ["COD_MUNICIPIO_ESC", int],
        "school_city_name"       : ["NO_MUNICIPIO_ESC"],
        "school_state_code"      : ["COD_UF_ESC", int],
        "school_state_name"      : ["UF_ESC"],
        "school_dependency"      : ["ID_DEPENDENCIA_ADM_ESC", int, dependency_enum],
        "school_location"        : ["ID_LOCALIZACAO_ESC", int, location_enum],
        "school_status"          : ["SIT_FUNC_ESC", int, status_enum],
        "age"                    : ["IDADE", int],
        "gender"                 : ["TP_SEXO", gender_enum],
        "nationality"            : ["NACIONALIDADE", int, nationality_enum],
        "birth_city_code"        : ["COD_MUNICIPIO_NASCIMENTO", int],
        "birth_city_name"        : ["NO_MUNICIPIO_NASCIMENTO"],
        "birth_state_code"       : ["COD_UF_NASCIMENTO", int],
        "birth_state_name"       : ["UF_NASCIMENTO"],
        "conclusion"             : ["ST_CONCLUSAO", int, conclusion_enum],
        "conclusion_year"        : ["ANO_CONCLUIU", int],
        "school_type"            : ["TP_ESCOLA", int, school_enum],
        "conclusion_type"        : ["IN_TP_ENSINO", int, conclusion_type_enum],
        "marital_status"         : ["TP_ESTADO_CIVIL", int, marital_enum],
        "color"                  : ["TP_COR_RACA", int, color_enum],
        "low_vision"             : ["IN_BAIXA_VISAO", int],
        "blind"                  : ["IN_CEGUEIRA", int],
        "deaf"                   : ["IN_SURDEZ", int],
        "hearing_deficiency"     : ["IN_DEFICIENCIA_AUDITIVA", int],
        "blind_deaf"             : ["IN_SURDO_CEGUEIRA", int],
        "physical_disability"    : ["IN_DEFICIENCIA_FISICA", int],
        "mental_disability"      : ["IN_DEFICIENCIA_MENTAL", int],
        "attention_deficit"      : ["IN_DEFICIT_ATENCAO", int],
        "dyslexia"               : ["IN_DISLEXIA", int],
        "pregnancy"              : ["IN_GESTANTE", int],
        "lactating"              : ["IN_LACTANTE", int],
        "elderly"                : ["IN_IDOSO", int],
        "autism"                 : ["IN_AUTISMO", int],
        "sabbatista"             : ["IN_SABATISTA", int],
        "braille"                : ["IN_BRAILLE", int],
        "enlarged_big"           : ["IN_AMPLIADA_24", int],
        "enlarged_medium"        : ["IN_AMPLIADA_18", int],
        "reader"                 : ["IN_LEDOR", int],
        "easy_access"            : ["IN_ACESSO", int],
        "transcription"          : ["IN_TRANSCRICAO", int],
        "hand_talk"              : ["IN_LIBRAS", int],
        "lip_reading"            : ["IN_LEITURA_LABIAL", int],
        "wheelchair"             : ["IN_MESA_CADEIRA_RODAS", int],
        "separated_chair"        : ["IN_MESA_CADEIRA_SEPARADA", int],
        "leg_support"            : ["IN_APOIO_PERNA", int],
        "interpret_guide"        : ["IN_GUIA_INTERPRETE", int],
        "certification"          : ["IN_CERTIFICADO", int],
        "certifier_name"         : ["NO_ENTIDADE_CERTIFICACAO"],
        "certifier_state_code"   : ["COD_UF_ENTIDADE_CERTIFICACAO", int],
        "certifier_state_name"   : ["UF_ENTIDADE_CERTIFICACAO"],
        "test_city_code"         : ["COD_MUNICIPIO_PROVA", int],
        "test_city_name"         : ["NO_MUNICIPIO_PROVA"],
        "test_state_code"        : ["COD_UF_PROVA", int],
        "test_state_name"        : ["UF_PROVA"],
        "cn_presence"            : ["IN_PRESENCA_CN", int, presence_enum],
        "ch_presence"            : ["IN_PRESENCA_CH", int, presence_enum],
        "lc_presence"            : ["IN_PRESENCA_LC", int, presence_enum],
        "mt_presence"            : ["IN_PRESENCA_MT", int, presence_enum],
        "cn_test_code"           : ["ID_PROVA_CN", int],
        "ch_test_code"           : ["ID_PROVA_CH", int],
        "lc_test_code"           : ["ID_PROVA_LC", int],
        "mt_test_code"           : ["ID_PROVA_MT", int],
        "cn_score"               : ["NOTA_CN", float],
        "ch_score"               : ["NOTA_CH", float],
        "lc_score"               : ["NOTA_LC", float],
        "mt_score"               : ["NOTA_MT", float],
        "cn_answers"             : ["TX_RESPOSTAS_CN", filter_answers],
        "ch_answers"             : ["TX_RESPOSTAS_CH", filter_answers],
        "lc_answers"             : ["TX_RESPOSTAS_LC", filter_answers],
        "mt_answers"             : ["TX_RESPOSTAS_MT", filter_answers],
        "lc_type"                : ["TP_LINGUA", int, lc_enum],
        "cn_key"                 : ["GABARITO_CN"],
        "ch_key"                 : ["GABARITO_CH"],
        "lc_key"                 : ["GABARITO_LC"],
        "mt_key"                 : ["GABARITO_MT"],
        "essay_status"           : ["IN_STATUS_REDACAO", int, essay_enum],
        "first_competence_score" : ["NU_NOTA_COMP1", float],
        "second_competence_score": ["NU_NOTA_COMP2", float],
        "third_competence_score" : ["NU_NOTA_COMP3", float],
        "fourth_competence_score": ["NU_NOTA_COMP4", float],
        "fifth_competence_score" : ["NU_NOTA_COMP5", float],
        "essay_score"            : ["NU_NOTA_REDACAO", float]
    }

    return (mappings, consistency)

def presets_2013():
    return presets_2014()

def presets_2012():
    def dependency_enum(value):
        mapping = { 1: "federal", 2: "state", 3: "city", 4: "private" }
        return mapping[value]

    def location_enum(value):
        mapping = { 1: "urban", 2: "rural" }
        return mapping[value]

    def status_enum(value):
        mapping = { 1: "active", 2: "inactive", 3: "extinct", 4: "extinct" }
        return mapping[value]

    def gender_enum(value):
        mapping = { 0: "male", 1: "female" }
        return mapping[value]

    def nationality_enum(value):
        mapping = { 1: "natural", 2: "naturalized", 3: "foreign", 4: "abroad" }
        return mapping[value]

    def conclusion_enum(value):
        mapping = { 1: "completed", 2: "current", 3: "future", 4: "incomplete" }
        return mapping[value]

    def school_enum(value):
        mapping = { 1: "public", 2: "private" }
        return mapping[value]

    def conclusion_type_enum(value):
        mapping = { 1: "regular", 2: "youth", 3: "professional", 4: "special" }
        return mapping[value]

    def marital_enum(value):
        mapping = { 0: "single", 1: "married", 2: "divorced", 3: "widower" }
        return mapping[value]

    def color_enum(value):
        mapping = {
            0: None,
            1: "white",
            2: "black",
            3: "brown",
            4: "yellow",
            5: "indigene"}
        return mapping[value]

    def presence_enum(value):
        mapping = { 0: "missed", 1: "present", 2: "eliminated" }
        return mapping[value]

    def lc_enum(value):
        mapping = { 0: "english", 1: "spanish" }
        return mapping[value]

    def essay_enum(value):
        mapping = {
            "P": "ok",
            "B": "empty",
            "T": "escape",
            "N": "nullified",
            "I": "insufficient",
            "A": "incorrect",
            "H": "hurt",
            "C": "copy",
            "F": "missed" }
        return mapping[value]

    def filter_answers(answers):
        return re.sub(r"[^A-E]", "*", answers)

    return {
        "registration"           : ["NU_INSCRICAO", int],
        "year"                   : ["NU_ANO", int],
        "resident_city_code"     : ["COD_MUNICIPIO_INSC", int],
        "resident_city_name"     : ["NO_MUNICIPIO_INSC"],
        "resident_state_name"    : ["UF_INSC"],
        "hospital_unity"         : ["IN_UNIDADE_HOSPITALAR", int],
        "school_code"            : ["PK_COD_ENTIDADE", int],
        "school_city_code"       : ["COD_MUNICIPIO_ESC", int],
        "school_city_name"       : ["NO_MUNICIPIO_ESC"],
        "school_state_name"      : ["UF_ESC"],
        "school_dependency"      : ["ID_DEPENDENCIA_ADM", int, dependency_enum],
        "school_location"        : ["ID_LOCALIZACAO", int, location_enum],
        "school_status"          : ["SIT_FUNC", int, status_enum],
        "age"                    : ["IDADE", int],
        "gender"                 : ["TP_SEXO", int, gender_enum],
        "conclusion"             : ["ST_CONCLUSAO", int, conclusion_enum],
        "conclusion_year"        : ["ANO_CONCLUIU", int],
        "school_type"            : ["TP_ESCOLA", int, school_enum],
        "conclusion_type"        : ["IN_TP_ENSINO", int, conclusion_type_enum],
        "marital_status"         : ["TP_ESTADO_CIVIL", int, marital_enum],
        "color"                  : ["TP_COR_RACA", int, color_enum],
        "low_vision"             : ["IN_BAIXA_VISAO", int],
        "blind"                  : ["IN_CEGUEIRA", int],
        "deaf"                   : ["IN_SURDEZ", int],
        "hearing_deficiency"     : ["IN_DEFICIENCIA_AUDITIVA", int],
        "blind_deaf"             : ["IN_SURDO_CEGUEIRA", int],
        "physical_disability"    : ["IN_DEFICIENCIA_FISICA", int],
        "mental_disability"      : ["IN_DEFICIENCIA_MENTAL", int],
        "attention_deficit"      : ["IN_DEFICIT_ATENCAO", int],
        "dyslexia"               : ["IN_DISLEXIA", int],
        "pregnancy"              : ["IN_GESTANTE", int],
        "lactating"              : ["IN_LACTANTE", int],
        "elderly"                : ["IN_IDOSO", int],
        "autism"                 : ["IN_AUTISMO", int],
        "sabbatista"             : ["IN_SABATISTA", int],
        "braille"                : ["IN_BRAILLE", int],
        "enlarged_big"           : ["IN_AMPLIADA", int],
        "reader"                 : ["IN_LEDOR", int],
        "easy_access"            : ["IN_ACESSO", int],
        "transcription"          : ["IN_TRANSCRICAO", int],
        "hand_talk"              : ["IN_LIBRAS", int],
        "lip_reading"            : ["IN_LEITURA_LABIAL", int],
        "wheelchair"             : ["IN_MESA_CADEIRA_RODAS", int],
        "separated_chair"        : ["IN_MESA_CADEIRA_SEPARADA", int],
        "leg_support"            : ["IN_APOIO_PERNA", int],
        "interpret_guide"        : ["IN_GUIA_INTERPRETE", int],
        "certification"          : ["IN_CERTIFICADO", int],
        "certifier_name"         : ["NO_ENTIDADE_CERTIFICACAO"],
        "certifier_state_name"   : ["UF_ENTIDADE_CERTIFICACAO"],
        "test_city_code"         : ["COD_MUNICIPIO_PROVA", int],
        "test_city_name"         : ["NO_MUNICIPIO_PROVA"],
        "test_state_name"        : ["UF_MUNICIPIO_PROVA"],
        "cn_presence"            : ["IN_PRESENCA_CN", int, presence_enum],
        "ch_presence"            : ["IN_PRESENCA_CH", int, presence_enum],
        "lc_presence"            : ["IN_PRESENCA_LC", int, presence_enum],
        "mt_presence"            : ["IN_PRESENCA_MT", int, presence_enum],
        "cn_test_code"           : ["ID_PROVA_CN", int],
        "ch_test_code"           : ["ID_PROVA_CH", int],
        "lc_test_code"           : ["ID_PROVA_LC", int],
        "mt_test_code"           : ["ID_PROVA_MT", int],
        "cn_score"               : ["NU_NT_CN", float],
        "ch_score"               : ["NU_NT_CH", float],
        "lc_score"               : ["NU_NT_LC", float],
        "mt_score"               : ["NU_NT_MT", float],
        "cn_answers"             : ["TX_RESPOSTAS_CN", filter_answers],
        "ch_answers"             : ["TX_RESPOSTAS_CH", filter_answers],
        "lc_answers"             : ["TX_RESPOSTAS_LC", filter_answers],
        "mt_answers"             : ["TX_RESPOSTAS_MT", filter_answers],
        "lc_type"                : ["TP_LINGUA", int, lc_enum],
        "cn_key"                 : ["DS_GABARITO_CN"],
        "ch_key"                 : ["DS_GABARITO_CH"],
        "lc_key"                 : ["DS_GABARITO_LC"],
        "mt_key"                 : ["DS_GABARITO_MT"],
        "essay_status"           : ["IN_STATUS_REDACAO", essay_enum],
        "first_competence_score" : ["NU_NOTA_COMP1", float],
        "second_competence_score": ["NU_NOTA_COMP2", float],
        "third_competence_score" : ["NU_NOTA_COMP3", float],
        "fourth_competence_score": ["NU_NOTA_COMP4", float],
        "fifth_competence_score" : ["NU_NOTA_COMP5", float],
        "essay_score"            : ["NU_NOTA_REDACAO", float]
    }

def presets_2011():
    def dependency_enum(value):
        mapping = { 1: "federal", 2: "state", 3: "city", 4: "private" }
        return mapping[value]

    def location_enum(value):
        mapping = { 1: "urban", 2: "rural" }
        return mapping[value]

    def status_enum(value):
        mapping = { 1: "active", 2: "inactive", 3: "extinct", 4: "extinct" }
        return mapping[value]

    def gender_enum(value):
        mapping = { 0: "male", 1: "female" }
        return mapping[value]

    def nationality_enum(value):
        mapping = { 1: "natural", 2: "naturalized", 3: "foreign", 4: "abroad" }
        return mapping[value]

    def conclusion_enum(value):
        mapping = { 1: "completed", 2: "current", 3: "future", 4: "incomplete" }
        return mapping[value]

    def school_enum(value):
        mapping = { 1: "public", 2: "private" }
        return mapping[value]

    def conclusion_type_enum(value):
        mapping = { 1: "regular", 2: "youth", 3: "professional", 4: "special" }
        return mapping[value]

    def marital_enum(value):
        mapping = { 0: "single", 1: "married", 2: "divorced", 3: "widower" }
        return mapping[value]

    def color_enum(value):
        mapping = {
            0: None,
            1: "white",
            2: "black",
            3: "brown",
            4: "yellow",
            5: "indigene"}
        return mapping[value]

    def presence_enum(value):
        mapping = { 0: "missed", 1: "present", 2: "eliminated" }
        return mapping[value]

    def lc_enum(value):
        mapping = { 0: "english", 1: "spanish" }
        return mapping[value]

    def essay_enum(value):
        mapping = {
            "B": "empty",
            "F": "missed",
            "N": "nullified",
            "P": "ok",
            "D": "eliminated" }
        return mapping[value]

    def filter_answers(answers):
        return re.sub(r"[^A-E]", "*", answers)

    def consistency(_):
        def consistent(transformed, original):
            registration = ALL_FIELDS_INDICES["registration"]
            consistency = ALL_FIELDS_INDICES["consistency"]
            school_code = ALL_FIELDS_INDICES["school_code"]
            school_state_code = ALL_FIELDS_INDICES["school_state_code"]
            school_state_name = ALL_FIELDS_INDICES["school_state_name"]
            school_city_code = ALL_FIELDS_INDICES["school_city_code"]
            school_city_name = ALL_FIELDS_INDICES["school_city_name"]
            school_dependency = ALL_FIELDS_INDICES["school_dependency"]
            school_location = ALL_FIELDS_INDICES["school_location"]
            school_status = ALL_FIELDS_INDICES["school_status"]

            if int(original["IN_CONCLUINTE_CENSO"]) == 0:
                transformed[consistency] = "unpresent"
            else:
                if (transformed[school_code] != int(original["COD_ENTIDADE_CENSO"])
                    or transformed[school_city_code] !=
                        int(original["COD_MUNICIPIO_ESC_CENSO"])
                    or transformed[school_city_name] != original["NO_MUNICIPIO_ESC_CENSO"]
                    or transformed[school_state_name] != original["UF_ESC_CENSO"]
                    or transformed[school_dependency] !=
                        dependency_enum(int(original["ID_DEPENDENCIA_ADM_CENSO"]))
                    or transformed[school_location] !=
                        location_enum(int(original["ID_LOCALIZACAO_CENSO"]))
                    or transformed[school_status] !=
                        status_enum(int(original["SIT_FUNC_CENSO"]))
                    ):

                    transformed[school_code] = int(original["COD_ENTIDADE_CENSO"])
                    transformed[school_city_code] = int(original["COD_MUNICIPIO_ESC_CENSO"])
                    transformed[school_city_name] = original["NO_MUNICIPIO_ESC_CENSO"]
                    transformed[school_state_name] = original["UF_ESC_CENSO"]
                    transformed[school_dependency] = dependency_enum(
                        int(original["ID_DEPENDENCIA_ADM_CENSO"]))
                    transformed[school_location] = location_enum(
                        int(original["ID_LOCALIZACAO_CENSO"]))
                    transformed[school_status] = status_enum(int(original["SIT_FUNC_CENSO"]))

                    transformed[school_state_code] = None
                    transformed[consistency] = "overwritten"
                else:
                    transformed[consistency] = "validated"
        return consistent

    mappings = {
        "registration"           : ["NU_INSCRICAO", int],
        "year"                   : ["NU_ANO", int],
        "resident_city_code"     : ["COD_MUNICIPIO_INSC", int],
        "resident_city_name"     : ["NO_MUNICIPIO_INSC"],
        "resident_state_name"    : ["UF_INSC"],
        "school_code"            : ["PK_COD_ENTIDADE", int],
        "school_city_code"       : ["COD_MUNICIPIO_ESC", int],
        "school_city_name"       : ["NO_MUNICIPIO_ESC"],
        "school_state_name"      : ["UF_ESC"],
        "school_dependency"      : ["ID_DEPENDENCIA_ADM", int, dependency_enum],
        "school_location"        : ["ID_LOCALIZACAO", int, location_enum],
        "school_status"          : ["SIT_FUNC", int, status_enum],
        "age"                    : ["IDADE", int],
        "gender"                 : ["TP_SEXO", int, gender_enum],
        "conclusion"             : ["ST_CONCLUSAO", int, conclusion_enum],
        "conclusion_type"        : ["IN_TP_ENSINO", int, conclusion_type_enum],
        "marital_status"         : ["TP_ESTADO_CIVIL", int, marital_enum],
        "color"                  : ["TP_COR_RACA", int, color_enum],
        "low_vision"             : ["IN_BAIXA_VISAO", int],
        "blind"                  : ["IN_CEGUEIRA", int],
        "deaf"                   : ["IN_SURDEZ", int],
        "hearing_deficiency"     : ["IN_DEFICIENCIA_AUDITIVA", int],
        "physical_disability"    : ["IN_DEFICIENCIA_FISICA", int],
        "mental_disability"      : ["IN_DEFICIENCIA_MENTAL", int],
        "attention_deficit"      : ["IN_DEFICIT_ATENCAO", int],
        "dyslexia"               : ["IN_DISLEXIA", int],
        "pregnancy"              : ["IN_GESTANTE", int],
        "lactating"              : ["IN_LACTANTE", int],
        "sabbatista"             : ["IN_SABATISTA", int],
        "braille"                : ["IN_BRAILLE", int],
        "enlarged_big"           : ["IN_AMPLIADA", int],
        "reader"                 : ["IN_LEDOR", int],
        "easy_access"            : ["IN_ACESSO", int],
        "transcription"          : ["IN_TRANSCRICAO", int],
        "hand_talk"              : ["IN_LIBRAS", int],
        "lip_reading"            : ["IN_LEITURA_LABIAL", int],
        "prison_unity"           : ["IN_UNIDADE_PRISIONAL", int],
        "certification"          : ["IN_CERTIFICADO", int],
        "test_city_code"         : ["COD_MUNICIPIO_PROVA", int],
        "test_city_name"         : ["NO_MUNICIPIO_PROVA"],
        "test_state_name"        : ["UF_MUNICIPIO_PROVA"],
        "cn_presence"            : ["IN_PRESENCA_CN", int, presence_enum],
        "ch_presence"            : ["IN_PRESENCA_CH", int, presence_enum],
        "lc_presence"            : ["IN_PRESENCA_LC", int, presence_enum],
        "mt_presence"            : ["IN_PRESENCA_MT", int, presence_enum],
        "cn_test_code"           : ["ID_PROVA_CN", int],
        "ch_test_code"           : ["ID_PROVA_CH", int],
        "lc_test_code"           : ["ID_PROVA_LC", int],
        "mt_test_code"           : ["ID_PROVA_MT", int],
        "cn_score"               : ["NU_NT_CN", float],
        "ch_score"               : ["NU_NT_CH", float],
        "lc_score"               : ["NU_NT_LC", float],
        "mt_score"               : ["NU_NT_MT", float],
        "cn_answers"             : ["TX_RESPOSTAS_CN", filter_answers],
        "ch_answers"             : ["TX_RESPOSTAS_CH", filter_answers],
        "lc_answers"             : ["TX_RESPOSTAS_LC", filter_answers],
        "mt_answers"             : ["TX_RESPOSTAS_MT", filter_answers],
        "lc_type"                : ["TP_LINGUA", int, lc_enum],
        "cn_key"                 : ["DS_GABARITO_CN"],
        "ch_key"                 : ["DS_GABARITO_CH"],
        "lc_key"                 : ["DS_GABARITO_LC"],
        "mt_key"                 : ["DS_GABARITO_MT"],
        "essay_status"           : ["IN_STATUS_REDACAO", essay_enum],
        "first_competence_score" : ["NU_NOTA_COMP1", float],
        "second_competence_score": ["NU_NOTA_COMP2", float],
        "third_competence_score" : ["NU_NOTA_COMP3", float],
        "fourth_competence_score": ["NU_NOTA_COMP4", float],
        "fifth_competence_score" : ["NU_NOTA_COMP5", float],
        "essay_score"            : ["NU_NOTA_REDACAO", float]
    }

    return (mappings, consistency)

def presets_2010():
    def dependency_enum(value):
        mapping = { 1: "federal", 2: "state", 3: "city", 4: "private" }
        return mapping[value]

    def location_enum(value):
        mapping = { 1: "urban", 2: "rural" }
        return mapping[value]

    def status_enum(value):
        mapping = { 1: "active", 2: "inactive", 3: "extinct", 4: "extinct" }
        return mapping[value]

    def gender_enum(value):
        mapping = { "M": "male", "F": "female" }
        return mapping[value]

    def nationality_enum(value):
        mapping = { 1: "natural", 2: "naturalized", 3: "foreign", 4: "abroad" }
        return mapping[value]

    def conclusion_enum(value):
        mapping = { 1: "completed", 2: "current", 3: "future" }
        return mapping[value]

    def school_enum(value):
        mapping = { 1: "public", 2: "private" }
        return mapping[value]

    def conclusion_type_enum(value):
        mapping = { 1: "regular", 2: "youth", 3: "professional", 4: "special" }
        return mapping[value]

    def marital_enum(value):
        mapping = {
            0: "single",
            1: "married",
            2: "married",
            3: "married",
            4: "divorced",
            5: "divorced",
            6: "widower" }
        return mapping[value]

    def color_enum(value):
        mapping = {
            0: None,
            1: "white",
            2: "black",
            3: "brown",
            4: "yellow",
            5: "indigene"}
        return mapping[value]

    def presence_enum(value):
        mapping = { 0: "missed", 1: "present", 2: "eliminated" }
        return mapping[value]

    def lc_enum(value):
        mapping = { 0: "english", 1: "spanish" }
        return mapping[value]

    def essay_enum(value):
        mapping = {
            "B": "empty",
            "F": "missed",
            "N": "nullified",
            "P": "ok",
            "D": "eliminated" }
        return mapping[value]

    def filter_answers(answers):
        return re.sub(r"[^A-E]", "*", answers)

    return {
        "registration"           : ["NU_INSCRICAO", int],
        "year"                   : ["NU_ANO", int],
        "resident_city_code"     : ["COD_MUNICIPIO_INSC", int],
        "resident_city_name"     : ["NO_MUNICIPIO_INSC"],
        "resident_state_name"    : ["UF_INSC"],
        "school_code"            : ["PK_COD_ENTIDADE", int],
        "school_city_code"       : ["COD_MUNICIPIO_ESC", int],
        "school_city_name"       : ["NO_MUNICIPIO_ESC"],
        "school_state_name"      : ["UF_ESC"],
        "school_dependency"      : ["ID_DEPENDENCIA_ADM", int, dependency_enum],
        "school_location"        : ["ID_LOCALIZACAO", int, location_enum],
        "school_status"          : ["SIT_FUNC", int, status_enum],
        "age"                    : ["IDADE", int],
        "gender"                 : ["TP_SEXO", gender_enum],
        "conclusion"             : ["ST_CONCLUSAO", int, conclusion_enum],
        "conclusion_type"        : ["IN_TP_ENSINO", int, conclusion_type_enum],
        "marital_status"         : ["TP_ESTADO_CIVIL", int, marital_enum],
        "color"                  : ["TP_COR_RACA", int, color_enum],
        "low_vision"             : ["IN_BAIXA_VISAO", int],
        "blind"                  : ["IN_CEGUEIRA", int],
        "deaf"                   : ["IN_SURDEZ", int],
        "hearing_deficiency"     : ["IN_DEFICIENCIA_AUDITIVA", int],
        "physical_disability"    : ["IN_DEFICIENCIA_FISICA", int],
        "mental_disability"      : ["IN_DEFICIENCIA_MENTAL", int],
        "attention_deficit"      : ["IN_DEFICIT_ATENCAO", int],
        "dyslexia"               : ["IN_DISLEXIA", int],
        "pregnancy"              : ["IN_GESTANTE", int],
        "lactating"              : ["IN_LACTANTE", int],
        "sabbatista"             : ["IN_SABATISTA", int],
        "braille"                : ["IN_BRAILLE", int],
        "enlarged_big"           : ["IN_AMPLIADA", int],
        "reader"                 : ["IN_LEDOR", int],
        "easy_access"            : ["IN_ACESSO", int],
        "transcription"          : ["IN_TRANSCRICAO", int],
        "hand_talk"              : ["IN_LIBRAS", int],
        "lip_reading"            : ["IN_LEITURA_LABIAL", int],
        "prison_unity"           : ["IN_UNIDADE_PRISIONAL", int],
        "certification"          : ["IN_CERTIFICADO", int],
        "test_city_code"         : ["COD_MUNICIPIO_PROVA", int],
        "test_city_name"         : ["NO_MUNICIPIO_PROVA"],
        "test_state_name"        : ["UF_MUNICIPIO_PROVA"],
        "cn_presence"            : ["IN_PRESENCA_CN", int, presence_enum],
        "ch_presence"            : ["IN_PRESENCA_CH", int, presence_enum],
        "lc_presence"            : ["IN_PRESENCA_LC", int, presence_enum],
        "mt_presence"            : ["IN_PRESENCA_MT", int, presence_enum],
        "cn_test_code"           : ["ID_PROVA_CN", int],
        "ch_test_code"           : ["ID_PROVA_CH", int],
        "lc_test_code"           : ["ID_PROVA_LC", int],
        "mt_test_code"           : ["ID_PROVA_MT", int],
        "cn_score"               : ["NU_NT_CN", float],
        "ch_score"               : ["NU_NT_CH", float],
        "lc_score"               : ["NU_NT_LC", float],
        "mt_score"               : ["NU_NT_MT", float],
        "cn_answers"             : ["TX_RESPOSTAS_CN", filter_answers],
        "ch_answers"             : ["TX_RESPOSTAS_CH", filter_answers],
        "lc_answers"             : ["TX_RESPOSTAS_LC", filter_answers],
        "mt_answers"             : ["TX_RESPOSTAS_MT", filter_answers],
        "lc_type"                : ["TP_LINGUA", int, lc_enum],
        "cn_key"                 : ["DS_GABARITO_CN"],
        "ch_key"                 : ["DS_GABARITO_CH"],
        "lc_key"                 : ["DS_GABARITO_LC"],
        "mt_key"                 : ["DS_GABARITO_MT"],
        "essay_status"           : ["IN_STATUS_REDACAO", essay_enum],
        "first_competence_score" : ["NU_NOTA_COMP1", float],
        "second_competence_score": ["NU_NOTA_COMP2", float],
        "third_competence_score" : ["NU_NOTA_COMP3", float],
        "fourth_competence_score": ["NU_NOTA_COMP4", float],
        "fifth_competence_score" : ["NU_NOTA_COMP5", float],
        "essay_score"            : ["NU_NOTA_REDACAO", float]
    }

def presets_2009():
    def dependency_enum(value):
        mapping = { 1: "federal", 2: "state", 3: "city", 4: "private" }
        return mapping[value]

    def location_enum(value):
        mapping = { 1: "urban", 2: "rural" }
        return mapping[value]

    def status_enum(value):
        mapping = { 1: "active", 2: "inactive", 3: "extinct", 4: "extinct" }
        return mapping[value]

    def gender_enum(value):
        mapping = { "M": "male", "F": "female" }
        return mapping[value]

    def nationality_enum(value):
        mapping = { 1: "natural", 2: "naturalized", 3: "foreign", 4: "abroad" }
        return mapping[value]

    def conclusion_enum(value):
        mapping = { 1: "completed", 2: "current", 3: "future" , 4: "incomplete"}
        return mapping[value]

    def school_enum(value):
        mapping = { 1: "public", 2: "private" }
        return mapping[value]

    def conclusion_type_enum(value):
        mapping = { 1: "regular", 2: "youth", 3: "professional", 4: "special" }
        return mapping[value]

    def marital_enum(value):
        mapping = {
            0: "single",
            1: "married",
            2: "married",
            3: "married",
            4: "divorced",
            5: "divorced",
            6: "widower" }
        return mapping[value]

    def color_enum(value):
        mapping = {
            0: None,
            1: "white",
            2: "black",
            3: "brown",
            4: "yellow",
            5: "indigene"}
        return mapping[value]

    def presence_enum(value):
        mapping = { 0: "missed", 1: "present", 2: "eliminated" }
        return mapping[value]

    def lc_enum(value):
        mapping = { 0: "english", 1: "spanish" }
        return mapping[value]

    def essay_enum(value):
        mapping = {
            "B": "empty",
            "F": "missed",
            "N": "nullified",
            "P": "ok" }
        return mapping[value]

    def filter_answers(answers):
        return re.sub(r"[^A-E]", "*", answers)

    return {
        "registration"           : ["NU_INSCRICAO", int],
        "year"                   : ["NU_ANO", int],
        "resident_city_code"     : ["COD_MUNIC_INSC", int],
        "resident_city_name"     : ["NO_MUNICIPIO_INSC"],
        "resident_state_name"    : ["UF_INSC"],
        "school_code"            : ["PK_COD_ENTIDADE", int],
        "school_city_code"       : ["COD_MUNICIPIO_ESC", int],
        "school_city_name"       : ["NO_MUNICIPIO_ESC"],
        "school_state_name"      : ["UF_ESC"],
        "school_dependency"      : ["ID_DEPENDENCIA_ADM", int, dependency_enum],
        "school_location"        : ["ID_LOCALIZACAO", int, location_enum],
        "school_status"          : ["SIT_FUNC", int, status_enum],
        "age"                    : ["IDADE", int, ],
        "gender"                 : ["TP_SEXO", gender_enum],
        "conclusion"             : ["ST_CONCLUSAO", int, conclusion_enum],
        "conclusion_type"        : ["IN_TP_ENSINO", int, conclusion_type_enum],
        "braille"                : ["IN_BRAILLE", int],
        "enlarged_big"           : ["IN_AMPLIADA", int],
        "reader"                 : ["IN_LEDOR", int],
        "easy_access"            : ["IN_ACESSO", int],
        "transcription"          : ["IN_TRANSCRICAO", int],
        "hand_talk"              : ["IN_LIBRAS", int],
        "other_necessity"        : ["IN_OUTRO", int],
        "prison_unity"           : ["IN_UNIDADE_PRISIONAL", int],
        "certification"          : ["IN_CERTIFICADO", int],
        "test_city_code"         : ["COD_MUNICIPIO_PROVA", int],
        "test_city_name"         : ["NO_MUNICIPIO_PROVA"],
        "test_state_name"        : ["UF_CIDADE_PROVA"],
        "cn_presence"            : ["IN_PRESENCA_CN", int, presence_enum],
        "ch_presence"            : ["IN_PRESENCA_CH", int, presence_enum],
        "lc_presence"            : ["IN_PRESENCA_LC", int, presence_enum],
        "mt_presence"            : ["IN_PRESENCA_MT", int, presence_enum],
        "cn_test_code"           : ["ID_PROVA_CN", int],
        "ch_test_code"           : ["ID_PROVA_CH", int],
        "lc_test_code"           : ["ID_PROVA_LC", int],
        "mt_test_code"           : ["ID_PROVA_MT", int],
        "cn_score"               : ["NU_NT_CN", float],
        "ch_score"               : ["NU_NT_CH", float],
        "lc_score"               : ["NU_NT_LC", float],
        "mt_score"               : ["NU_NT_MT", float],
        "cn_answers"             : ["TX_RESPOSTAS_CN", filter_answers],
        "ch_answers"             : ["TX_RESPOSTAS_CH", filter_answers],
        "lc_answers"             : ["TX_RESPOSTAS_LC", filter_answers],
        "mt_answers"             : ["TX_RESPOSTAS_MT", filter_answers],
        "cn_key"                 : ["DS_GABARITO_CN"],
        "ch_key"                 : ["DS_GABARITO_CH"],
        "lc_key"                 : ["DS_GABARITO_LC"],
        "mt_key"                 : ["DS_GABARITO_MT"],
        "essay_status"           : ["IN_STATUS_REDACAO", essay_enum],
        "first_competence_score" : ["NU_NOTA_COMP1", float],
        "second_competence_score": ["NU_NOTA_COMP2", float],
        "third_competence_score" : ["NU_NOTA_COMP3", float],
        "fourth_competence_score": ["NU_NOTA_COMP4", float],
        "fifth_competence_score" : ["NU_NOTA_COMP5", float],
        "essay_score"            : ["NU_NOTA_REDACAO", float],
    }

def post_process_2015(transformed):
    cn_presence = transformed[ALL_FIELDS_INDICES["cn_presence"]]
    ch_presence = transformed[ALL_FIELDS_INDICES["ch_presence"]]
    lc_presence = transformed[ALL_FIELDS_INDICES["lc_presence"]]
    mt_presence = transformed[ALL_FIELDS_INDICES["mt_presence"]]

    if cn_presence != "present":
        transformed[ALL_FIELDS_INDICES["cn_answers"]] = None
        transformed[ALL_FIELDS_INDICES["cn_key"]] = None

    if ch_presence != "present":
        transformed[ALL_FIELDS_INDICES["ch_answers"]] = None
        transformed[ALL_FIELDS_INDICES["ch_key"]] = None

    if lc_presence != "present":
        transformed[ALL_FIELDS_INDICES["lc_answers"]] = None
        transformed[ALL_FIELDS_INDICES["lc_key"]] = None
    else:
        lc_key_index = ALL_FIELDS_INDICES["lc_key"]
        lc_answers_index = ALL_FIELDS_INDICES["lc_answers"]
        lc_type = transformed[ALL_FIELDS_INDICES["lc_type"]]
        lc_key = transformed[lc_key_index]
        lc_answers = transformed[lc_answers_index]

        if lc_type == "english":
            answers = lc_answers[0:5] + lc_answers[10:]
            key = lc_key[0:5] + lc_key[10:]
        else:
            answers = lc_answers[5:]
            key = lc_key[5:]

        transformed[lc_answers_index] = answers
        transformed[lc_key_index] = key

    if mt_presence != "present":
        transformed[ALL_FIELDS_INDICES["mt_answers"]] = None
        transformed[ALL_FIELDS_INDICES["mt_key"]] = None

def post_process_2014(transformed):
    cn_presence = transformed[ALL_FIELDS_INDICES["cn_presence"]]
    ch_presence = transformed[ALL_FIELDS_INDICES["ch_presence"]]
    lc_presence = transformed[ALL_FIELDS_INDICES["lc_presence"]]
    mt_presence = transformed[ALL_FIELDS_INDICES["mt_presence"]]

    if cn_presence != "present":
        transformed[ALL_FIELDS_INDICES["cn_answers"]] = None
        transformed[ALL_FIELDS_INDICES["cn_key"]] = None

    if ch_presence != "present":
        transformed[ALL_FIELDS_INDICES["ch_answers"]] = None
        transformed[ALL_FIELDS_INDICES["ch_key"]] = None

    if lc_presence != "present":
        transformed[ALL_FIELDS_INDICES["lc_answers"]] = None
        transformed[ALL_FIELDS_INDICES["lc_key"]] = None
    else:
        lc_key_index = ALL_FIELDS_INDICES["lc_key"]
        lc_type = transformed[ALL_FIELDS_INDICES["lc_type"]]
        lc_key = transformed[lc_key_index]

        if lc_type == "english":
            key = lc_key[0:5] + lc_key[10:]
        else:
            key = lc_key[5:]

        transformed[lc_key_index] = key

    if mt_presence != "present":
        transformed[ALL_FIELDS_INDICES["mt_answers"]] = None
        transformed[ALL_FIELDS_INDICES["mt_key"]] = None

def post_process_2009(transformed):
    cn_presence = transformed[ALL_FIELDS_INDICES["cn_presence"]]
    ch_presence = transformed[ALL_FIELDS_INDICES["ch_presence"]]
    lc_presence = transformed[ALL_FIELDS_INDICES["lc_presence"]]
    mt_presence = transformed[ALL_FIELDS_INDICES["mt_presence"]]

    if cn_presence != "present":
        transformed[ALL_FIELDS_INDICES["cn_answers"]] = None
        transformed[ALL_FIELDS_INDICES["cn_key"]] = None

    if ch_presence != "present":
        transformed[ALL_FIELDS_INDICES["ch_answers"]] = None
        transformed[ALL_FIELDS_INDICES["ch_key"]] = None

    if lc_presence != "present":
        transformed[ALL_FIELDS_INDICES["lc_answers"]] = None
        transformed[ALL_FIELDS_INDICES["lc_key"]] = None

    if mt_presence != "present":
        transformed[ALL_FIELDS_INDICES["mt_answers"]] = None
        transformed[ALL_FIELDS_INDICES["mt_key"]] = None

def csv_iterator(filename):
    with open(filename, "r", newline="", encoding="iso-8859-1") as data:
        reader = csv.DictReader(data)

        for values in reader:
            yield values

def csv_iterator_2013(filename):
    with open(filename, "r", newline="", encoding="iso-8859-1") as data:
        reader = csv.DictReader(data, delimiter=";")

        for values in reader:
            yield values

def txt_2011_iterator(filename):
    with open(filename, "r", encoding="iso-8859-1") as data:
        for line in data:
            yield {
                "NU_INSCRICAO"            : line[0   :12].strip(),
                "NU_ANO"                  : line[12  :16].strip(),
                "COD_MUNICIPIO_INSC"      : line[20  :27].strip(),
                "NO_MUNICIPIO_INSC"       : line[27  :177].strip(),
                "UF_INSC"                 : line[177 :179].strip(),
                "PK_COD_ENTIDADE"         : line[203 :211].strip(),
                "COD_MUNICIPIO_ESC"       : line[211 :218].strip(),
                "NO_MUNICIPIO_ESC"        : line[218 :368].strip(),
                "UF_ESC"                  : line[368 :370].strip(),
                "ID_DEPENDENCIA_ADM"      : line[370 :371].strip(),
                "ID_LOCALIZACAO"          : line[371 :372].strip(),
                "SIT_FUNC"                : line[372 :373].strip(),
                "IDADE"                   : line[16  :19].strip(),
                "TP_SEXO"                 : line[19  :20].strip(),
                "ST_CONCLUSAO"            : line[179 :180].strip(),
                "IN_TP_ENSINO"            : line[180 :181].strip(),
                "TP_ESTADO_CIVIL"         : line[201 :202].strip(),
                "TP_COR_RACA"             : line[202 :203].strip(),
                "IN_BAIXA_VISAO"          : line[189 :190].strip(),
                "IN_CEGUEIRA"             : line[190 :191].strip(),
                "IN_SURDEZ"               : line[200 :201].strip(),
                "IN_DEFICIENCIA_AUDITIVA" : line[191 :192].strip(),
                "IN_DEFICIENCIA_FISICA"   : line[192 :193].strip(),
                "IN_DEFICIENCIA_MENTAL"   : line[193 :194].strip(),
                "IN_DEFICIT_ATENCAO"      : line[194 :195].strip(),
                "IN_DISLEXIA"             : line[195 :196].strip(),
                "IN_GESTANTE"             : line[196 :197].strip(),
                "IN_LACTANTE"             : line[197 :198].strip(),
                "IN_SABATISTA"            : line[199 :200].strip(),
                "IN_BRAILLE"              : line[182 :183].strip(),
                "IN_AMPLIADA"             : line[183 :184].strip(),
                "IN_LEDOR"                : line[184 :185].strip(),
                "IN_ACESSO"               : line[185 :186].strip(),
                "IN_TRANSCRICAO"          : line[186 :187].strip(),
                "IN_LIBRAS"               : line[187 :188].strip(),
                "IN_LEITURA_LABIAL"       : line[198 :199].strip(),
                "IN_UNIDADE_PRISIONAL"    : line[188 :189].strip(),
                "IN_CERTIFICADO"          : line[181 :182].strip(),
                "COD_MUNICIPIO_PROVA"     : line[373 :380].strip(),
                "NO_MUNICIPIO_PROVA"      : line[380 :530].strip(),
                "UF_MUNICIPIO_PROVA"      : line[530 :532].strip(),
                "IN_PRESENCA_CN"          : line[532 :533].strip(),
                "IN_PRESENCA_CH"          : line[533 :534].strip(),
                "IN_PRESENCA_LC"          : line[534 :535].strip(),
                "IN_PRESENCA_MT"          : line[535 :536].strip(),
                "ID_PROVA_CN"             : line[752 :755].strip(),
                "ID_PROVA_CH"             : line[755 :758].strip(),
                "ID_PROVA_LC"             : line[758 :761].strip(),
                "ID_PROVA_MT"             : line[761 :764].strip(),
                "NU_NT_CN"                : line[536 :545].strip(),
                "NU_NT_CH"                : line[545 :554].strip(),
                "NU_NT_LC"                : line[554 :563].strip(),
                "NU_NT_MT"                : line[563 :572].strip(),
                "TX_RESPOSTAS_CN"         : line[572 :617].strip(),
                "TX_RESPOSTAS_CH"         : line[617 :662].strip(),
                "TX_RESPOSTAS_LC"         : line[662 :707].strip(),
                "TX_RESPOSTAS_MT"         : line[707 :752].strip(),
                "TP_LINGUA"               : line[764 :765].strip(),
                "DS_GABARITO_CN"          : line[765 :810].strip(),
                "DS_GABARITO_CH"          : line[810 :855].strip(),
                "DS_GABARITO_LC"          : line[855 :905].strip(),
                "DS_GABARITO_MT"          : line[905 :950].strip(),
                "IN_STATUS_REDACAO"       : line[950 :951].strip(),
                "NU_NOTA_COMP1"           : line[951 :960].strip(),
                "NU_NOTA_COMP2"           : line[960 :969].strip(),
                "NU_NOTA_COMP3"           : line[969 :978].strip(),
                "NU_NOTA_COMP4"           : line[978 :987].strip(),
                "NU_NOTA_COMP5"           : line[987 :996].strip(),
                "NU_NOTA_REDACAO"         : line[996 :1005].strip(),
                'IN_CONCLUINTE_CENSO'     : line[1005:1006].strip(),
                'COD_ETAPA_ENSINO_CENSO'  : line[1006:1008].strip(),
                'COD_ENTIDADE_CENSO'      : line[1008:1016].strip(),
                'COD_MUNICIPIO_ESC_CENSO' : line[1016:1023].strip(),
                'NO_MUNICIPIO_ESC_CENSO'  : line[1023:1173].strip(),
                'UF_ESC_CENSO'            : line[1173:1175].strip(),
                'ID_DEPENDENCIA_ADM_CENSO': line[1175:1176].strip(),
                'ID_LOCALIZACAO_CENSO'    : line[1176:1177].strip(),
                'SIT_FUNC_CENSO'          : line[1177:1178].strip()
            }

def txt_2009_iterator(filename):
    with open(filename, "r", encoding="iso-8859-1") as data:
        for line in data:
            yield {
                'NU_INSCRICAO'        : line[0  :12].strip(),
                'NU_ANO'              : line[12 :16].strip(),
                'IDADE'               : line[16 :19].strip(),
                'TP_SEXO'             : line[19 :20].strip(),
                'COD_MUNIC_INSC'      : line[20 :27].strip(),
                'NO_MUNICIPIO_INSC'   : line[27 :177].strip(),
                'UF_INSC'             : line[177:179].strip(),
                'ST_CONCLUSAO'        : line[179:180].strip(),
                'IN_TP_ENSINO'        : line[180:181].strip(),
                'IN_CERTIFICADO'      : line[181:182].strip(),
                'IN_BRAILLE'          : line[182:183].strip(),
                'IN_AMPLIADA'         : line[183:184].strip(),
                'IN_LEDOR'            : line[184:185].strip(),
                'IN_ACESSO'           : line[185:186].strip(),
                'IN_TRANSCRICAO'      : line[186:187].strip(),
                'IN_OUTRO'            : line[187:188].strip(),
                'IN_LIBRAS'           : line[188:189].strip(),
                'IN_UNIDADE_PRISIONAL': line[189:190].strip(),
                'PK_COD_ENTIDADE'     : line[190:198].strip(),
                'COD_MUNICIPIO_ESC'   : line[198:205].strip(),
                'NO_MUNICIPIO_ESC'    : line[205:355].strip(),
                'UF_ESC'              : line[355:357].strip(),
                'ID_DEPENDENCIA_ADM'  : line[357:358].strip(),
                'ID_LOCALIZACAO'      : line[358:359].strip(),
                'SIT_FUNC'            : line[359:360].strip(),
                'COD_MUNICIPIO_PROVA' : line[360:367].strip(),
                'NO_MUNICIPIO_PROVA'  : line[367:517].strip(),
                'UF_CIDADE_PROVA'     : line[517:519].strip(),
                'IN_PRESENCA_CN'      : line[519:520].strip(),
                'IN_PRESENCA_CH'      : line[520:521].strip(),
                'IN_PRESENCA_LC'      : line[521:522].strip(),
                'IN_PRESENCA_MT'      : line[522:523].strip(),
                'NU_NT_CN'            : line[523:532].strip(),
                'NU_NT_CH'            : line[532:541].strip(),
                'NU_NT_LC'            : line[541:550].strip(),
                'NU_NT_MT'            : line[550:559].strip(),
                'TX_RESPOSTAS_CN'     : line[559:604].strip(),
                'TX_RESPOSTAS_CH'     : line[604:649].strip(),
                'TX_RESPOSTAS_LC'     : line[649:694].strip(),
                'TX_RESPOSTAS_MT'     : line[694:739].strip(),
                'ID_PROVA_CN'         : line[739:741].strip(),
                'ID_PROVA_CH'         : line[741:743].strip(),
                'ID_PROVA_LC'         : line[743:745].strip(),
                'ID_PROVA_MT'         : line[745:747].strip(),
                'DS_GABARITO_CN'      : line[747:792].strip(),
                'DS_GABARITO_CH'      : line[792:837].strip(),
                'DS_GABARITO_LC'      : line[837:882].strip(),
                'DS_GABARITO_MT'      : line[882:927].strip(),
                'IN_STATUS_REDACAO'   : line[927:928].strip(),
                'NU_NOTA_COMP1'       : line[928:937].strip(),
                'NU_NOTA_COMP2'       : line[937:946].strip(),
                'NU_NOTA_COMP3'       : line[946:955].strip(),
                'NU_NOTA_COMP4'       : line[955:964].strip(),
                'NU_NOTA_COMP5'       : line[964:973].strip(),
                'NU_NOTA_REDACAO'     : line[973:982].strip()
            }
def parse_file(inputpath, outputpath, fields, mappings, post_process, iterator,
               consistency_function=None):
    def parse_row(values):
        def fetch(field):
            if field not in mappings:
                return None

            key, *fns = mappings[field]
            value = values[key]

            if re.match(r"^\.*$", value):
                return None

            for fn in fns:
                value = fn(value)

            return value

        transformed = list(map(fetch, fields))
        post_process(transformed)
        return transformed

    with open(outputpath, "w", newline="") as outputpath:
        writer = csv.writer(outputpath)
        writer.writerow(fields)

        for line, values in enumerate(iterator(inputpath)):
            transformed = parse_row(values)

            if consistency_function:
                consistency_function(transformed, values)

            writer.writerow(transformed)

            if (line+1) % 10000 == 0:
                print("%d lines parsed" % (line + 1))

        print("All lines parsed")

def generate_sql(outputpath, fields):
    def variable(name):
        return "@%s" % name

    def attribution(name):
        return "%s = NULLIF(@%s, '')" % (name, name)

    variables = ", ".join(map(variable, fields))
    attributions = ", ".join(map(attribution, fields))
    sql = """\
        LOAD DATA INFILE "%s"
        INTO TABLE rawdata
        FIELDS TERMINATED BY ","
        LINES TERMINATED BY "\\n"
        IGNORE 1 LINES
        (%s)
        SET %s;
    """
    with open("%s.sql" % outputpath, "w") as outputfile:
        outputfile.write(sql % (outputpath, variables, attributions))


def no_consistency(transformed, original):
    transformed[ALL_FIELDS_INDICES["consistency"]] = "unavailable"


mappings_2015, consistency_2015 = presets_2015()
mappings_2014, consistency_2014 = presets_2014()
mappings_2013, consistency_2013 = presets_2013()
mappings_2011, consistency_2011 = presets_2011()

PRESETS = {
    2016: (mappings_2016(), post_process_2016, csv_iterator_2013, no_consistency),
    2015: (mappings_2015, post_process_2015, csv_iterator, consistency_2015),
    2014: (mappings_2014, post_process_2014, csv_iterator, consistency_2014),
    2013: (mappings_2013, post_process_2014, csv_iterator_2013, consistency_2013),
    2012: (presets_2012(), post_process_2014, csv_iterator, no_consistency),
    2011: (mappings_2011, post_process_2014, txt_2011_iterator, consistency_2011),
    2010: (presets_2010(), post_process_2014, txt_2011_iterator, no_consistency),
    2009: (presets_2009(), post_process_2009, txt_2009_iterator, no_consistency)
}

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Black magic and normalization with INEP ENEM  microdata")
    parser.add_argument("year", type=int, help="year format")
    parser.add_argument("input", type=str, help="input file")
    parser.add_argument("output", type=str, help="output file")
    parser.add_argument("-c", dest="consistency_file", type=str, help="consistency file",
                        default=None)

    args = parser.parse_args()
    if args.year not in PRESETS:
        print("Year not implemented")
        exit(1)
    mappings, post_process, iterator, consistency = PRESETS[args.year]
    print("Generating SQL...")
    generate_sql(args.output, ALL_FIELDS)
    print("Parsing file")
    lookup = consistency(args.consistency_file) if args.consistency_file or args.year == 2011 else None
    parse_file(args.input, args.output, ALL_FIELDS, mappings, post_process, iterator,
               lookup)
