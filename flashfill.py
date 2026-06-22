import cvc5
from cvc5 import Kind

solver = cvc5.Solver()
solver.setOption("sygus", "true")

String = solver.getStringSort()

# SyGuS parameter
x = solver.mkVar(String, "x")

# Grammar non-terminal
Start = solver.mkVar(String, "Start")

# Create grammar before synthFun
grammar = solver.mkGrammar(
    [x],
    [Start]
)

grammar.addRule(Start, x)

grammar.addRule(
    Start,
    solver.mkTerm(
        Kind.STRING_CONCAT,
        x,
        solver.mkString("!")
    )
)

grammar.addRule(Start, solver.mkString(""))
grammar.addRule(Start, solver.mkString("!"))

# Synthesize concat_suffix(x) -> String
concat_suffix = solver.synthFun(
    "concat_suffix",
    [x],
    String,
    grammar
)

# Constraint:
# concat_suffix(x) = x ++ "!"
constraint = solver.mkTerm(
    Kind.EQUAL,
    solver.mkTerm(Kind.APPLY_UF, concat_suffix, x),
    solver.mkTerm(
        Kind.STRING_CONCAT,
        x,
        solver.mkString("!")
    )
)

solver.addSygusConstraint(constraint)

result = solver.checkSynth()

print("Result:", result)
print("Solution:")
