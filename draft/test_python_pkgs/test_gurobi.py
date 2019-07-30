import gurobipy

m = gurobipy.Model()
x = m.addVar(lb=0,name = "x")
y = m.addVar(lb=0,name = "y")
m.update()
m.setObjective(2*x + 3*y, gurobipy.GRB.MAXIMIZE)
m.addConstr(x + y <= 10)
m.update()
m.optimize()