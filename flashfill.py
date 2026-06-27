import cvc5
from cvc5 import Kind

solver = cvc5.Solver()
solver.setOption("sygus", "true")
solver.setOption("rlimit-per", "10000000")

String = solver.getStringSort()
Int = solver.getIntegerSort()

# SyGuS parameter
x = solver.mkVar(String, "x")

# Grammar non-terminal
Start = solver.mkVar(String, "Start")
Index = solver.mkVar(Int, "Index")
Str = solver.mkVar(String, "Str")

zero = solver.mkInteger(0)

# Create grammar before synthFun
grammar = solver.mkGrammar(
    [x],
    [Start, Str, Index],
)

grammar.addRule(Start, x)

# String-producing rules
grammar.addRules(
    Start,
    [
        x,
        solver.mkTerm(
            Kind.STRING_REPLACE,
            Str,
            solver.mkString("."),
            solver.mkString(",")
        ),
        solver.mkTerm(
            Kind.STRING_CONCAT,
            Str,
            Str
        )
    ]
)

# Useful substrings
grammar.addRules(
    Str,
    [
        x,
        solver.mkTerm(
            Kind.STRING_SUBSTR,
            x,
            zero,
            Index
        )
    ]
)

# Integer rules
grammar.addRules(
    Index,
    [
        zero,

        solver.mkTerm(
            Kind.STRING_INDEXOF,
            x,
            solver.mkString("@"),
            zero
        )
    ]
)


# Synthesize our function
f = solver.synthFun(
    "f",
    [x],
    String,
    grammar
)

constraint = solver.mkTerm(
    Kind.EQUAL,
    solver.mkTerm(
        Kind.APPLY_UF,
        f,
        solver.mkString("leia.organa@rebellion.net")
    ),
    solver.mkString("leia,organa")
)

solver.addSygusConstraint(constraint)

result = solver.checkSynth()

if result.hasSolution():
    sol = solver.getSynthSolution(f)
    print("Solution:", sol)

    test_input = solver.mkString("jane.doe@domain.org")
    application = solver.mkTerm(Kind.APPLY_UF, sol, test_input)
    result_term = solver.simplify(application)
    print("Applied to 'jane.doe@domain.org':", result_term)
else:
    print("No solution :(")
