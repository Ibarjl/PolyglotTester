# =============================================================================
# PolyglotTester.jl - Módulo Principal
# Framework de análisis estático multilenguaje con sistema de severidad
# =============================================================================

"""
PolyglotTester

Framework de análisis estático para múltiples lenguajes de programación con:
- Clasificación automática de severidad (CRITICAL → INFO)
- Health scoring por archivo (0-100)
- Reportes científicos avanzados con DataFrames
- Integración CI/CD nativa

## Uso básico
```julia
using PolyglotTester

# 🔍 Analizar un archivo específico que te preocupa
result = analyze_file("mi_api.py")
println("Salud del código: \$(result.health_score)/100")  # Ej: 75/100
println("Errores críticos: \$(result.critical_count)")    # Ej: 2

# 📁 Revisar todo tu proyecto de una vez
results = analyze_directory("src/")
println("Archivos con problemas: \$(length(results.failed_files))")

# 📊 Generar reporte visual para tu equipo
generate_report(results, format=:html, output="reporte_equipo.html")

# ⚡ Análisis súper rápido (una línea)
@analyze "mi_proyecto/"  # Te muestra todo al instante
```

## API Principal
- `analyze_file(path)` - Analiza un archivo individual
- `analyze_directory(path)` - Analiza todos los archivos de un directorio
- `generate_report(results, format)` - Genera reportes en múltiples formatos
- `PolyglotConfig()` - Configuración personalizada
"""
module PolyglotTester

using CSV
using DataFrames
using Dates
using JSON3
using Statistics
using TOML


# =============================================================================
# COMPONENTES CORE
# =============================================================================


# Tipos fundamentales y enums
include("core/types.jl")

# Sistema de clasificación de severidad
include("core/severity_classifier.jl")

# Detección automática de lenguajes
include("core/language_detector.jl")

# Calculadora de health scores
include("core/health_scorer.jl")

# Motor de métricas científicas
include("core/metrics_engine.jl")

# Configuración del framework
include("core/config.jl")

# =============================================================================
# ANALIZADORES
# =============================================================================

# Analizador genérico (funciona para cualquier lenguaje)
include("analyzers/generic_analyzer.jl")

# Analizadores específicos por lenguaje
include("analyzers/julia_analyzer.jl")
include("analyzers/python_analyzer.jl")
include("analyzers/javascript_analyzer.jl")
include("analyzers/cpp_analyzer.jl")

# Interfaz con herramientas externas
include("analyzers/external_tools.jl")

# =============================================================================
# REPORTERS
# =============================================================================

# Reporter base para consola
include("reporters/console_reporter.jl")

# Reporter especializado en severidad
include("reporters/severity_reporter.jl")

# Reportes ejecutivos para gerencia
include("reporters/executive_reporter.jl")

# Exportadores a diferentes formatos
include("reporters/json_reporter.jl")
include("reporters/html_reporter.jl")
include("reporters/junit_reporter.jl")

# =============================================================================
# UTILIDADES
# =============================================================================

# Utilidades de archivos y directorios
include("utils/file_utils.jl")

# Utilidades para ejecutar procesos externos
include("utils/process_utils.jl")

# Utilidades de patrones y regex
include("utils/pattern_utils.jl")

# =============================================================================
# RUNNER PRINCIPAL
# =============================================================================

# Coordinador que ejecuta todo el análisis
include("core/runner.jl")

# =============================================================================
# API PÚBLICA - EXPORTS
# =============================================================================

# Funciones principales que usuarios usarán
export analyze_file, analyze_directory
export generate_report

# Tipos y configuración
export PolyglotConfig, PolyglotResult
export Severity, Issue, TestResult

# Reporters disponibles
export ConsoleReporter, JSONReporter, HTMLReporter
export SeverityReporter, ExecutiveReporter

# Analizadores específicos
export JuliaAnalyzer, PythonAnalyzer, JavaScriptAnalyzer
export GenericAnalyzer

# Utilidades públicas
export detect_language, calculate_health_score
export classify_severity

# Macro conveniente
export @analyze

# =============================================================================
# MACROS
# =============================================================================

"""
    @analyze path [options...]

Macro conveniente para análisis rápido.

## Ejemplos
```julia
@analyze "mi_script.py"
@analyze "src/" verbose=true
@analyze "." format=:html output="report.html"
```
"""
macro analyze(path, options...)
    # Construir configuración desde opciones
    config_expr = :(PolyglotConfig())
    
    # Procesar opciones si las hay
    for opt in options
        if isa(opt, Expr) && opt.head == :(=)
            key, value = opt.args
            config_expr = :($config_expr; $key = $value)
        end
    end
    
    return quote
        local config = $config_expr
        local results = isfile($path) ? 
            analyze_file($path, config) : 
            analyze_directory($path, config)
        
        # Mostrar reporte por defecto
        generate_report(results, format=:console)
        results
    end
end

# =============================================================================
# INICIALIZACIÓN
# =============================================================================

"""
Función de inicialización del módulo.
Se ejecuta automáticamente al cargar PolyglotTester.
"""
function __init__()
    println("🧪 PolyglotTester.jl loaded successfully")
    println("   📊 Multi-language static analysis framework")
    println("   🎯 Severity classification: CRITICAL → INFO")
    println("   🏥 Health scoring: 0-100 per file")
    println("   📈 Scientific reporting with DataFrames")
    println()
    println("📖 Quick start:")
    println("   analyze_file(\"script.py\")")
    println("   @analyze \"src/\"")
    println()
end
end











