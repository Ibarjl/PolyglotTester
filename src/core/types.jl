using Dates



@enum Severity begin
    CRITICAL = 1    # 🔴 Errores que rompen ejecución
    HIGH = 2        # 🟠 Bugs funcionales graves
    MEDIUM = 3      # 🟡 Problemas de calidad
    LOW = 4         # 🔵 Estilo y convenciones
    INFO = 5        # ⚪ Información y métricas
end



Base.String(s::Severity) = string(Symbol(s))


severity_emoji(s::Severity) =   s == CRITICAL ? "🔴" :
                                s == HIGH ? "🟠" :
                                s == MEDIUM ? "🟡" :
                                s == LOW ? "🔵" : "⚪"


severity_color(s::Severity) =   s == CRITICAL ? :red :
                                s == HIGH ? :orange :
                                s == MEDIUM ? :yellow :
                                s == LOW ? :blue : :white




#* =============================================================================
#* ---ISSUE--- ---AHORA EMPIEZA LA PARTE PARA LOS PROBLEMAS INDIVIDUALES DETECTADOS---
#* =============================================================================


"""
    Issue

Representa un problema específico encontrado en el código.  #! IMPORTANTE TENER ESTO COMO UNA EJEMPO

## Campos:
- `id`: Identificador único del issue
- `file_path`: Ruta del archivo donde se encontró
- `line_number`: Línea específica (0 si aplica a todo el archivo)
- `column_number`: Columna específica (0 si aplica a toda la línea)
- `rule_id`: ID de la regla que detectó el problema
- `message`: Descripción clara del problema
- `severity`: Nivel de severidad (CRITICAL → INFO)
- `category`: Tipo de problema (:syntax, :logic, :style, :performance, :security)
- `fix_suggestion`: Sugerencia de cómo arreglar el problema
- `timestamp`: Cuándo se detectó

## Ejemplo:
    julia
issue = Issue(
    id="PY001",
    file_path="api.py",
    line_number=42,
    rule_id="sql-injection",
    message="Possible SQL injection vulnerability",
    severity=CRITICAL,
    category=:security,
    fix_suggestion="Use parameterized queries instead"
)
"""


struct Issu
    id::String
    file_path::String
    line_number::Int
    column_number::Int
    rule_id::String
    message::String
    severity::Severity
    category::Symbol  # :syntax, :logic, :style, :performance, :security
    fix_suggestion::String
    timestamp::DateTime
end



