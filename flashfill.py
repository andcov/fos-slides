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
    # FILL THIS IN
)

solver.addSygusConstraint(constraint)

result = solver.checkSynth()

if result.hasSolution():
    print("Solution:", solver.getSynthSolution(f))
else:
    print("No solution :(")
