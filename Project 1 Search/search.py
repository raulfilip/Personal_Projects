# search.py
# ---------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util
from game import Directions
from util import Queue,Stack
class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (successor,
        action, stepCost), where 'successor' is a successor to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that successor.
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    from game import Directions
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]
    # def depthFirstSearch(problem, visited=None, curentState=None, ok=0):
#     if ok==0:
#         curentState=problem.getStartState()
#         ok=1
#         visited=[]
#     visited.append(curentState)
#     if problem.isGoalState(curentState)==True:
#         return []
#     else:
#         succesorList=problem.getSuccessors(curentState)
#         for e in succesorList:
#             if e[0] not in visited:
#                 curentState=e[0]
#                 solution=depthFirstSearch(problem, visited, curentState, ok)
#                 if solution is not None:
#                     solution.insert(0,e[1])
#                     return solution


# tail_recursive v2
def depthFirstSearch(problem, visited=None, accumulator=None, curentState=None, ok=0):
    if ok==0:
        curentState=problem.getStartState()
        ok=1
        visited=[]
        accumulator = []
    visited.append(curentState)
    if problem.isGoalState(curentState)==True:
        return accumulator
    else:
        succesorList=problem.getSuccessors(curentState)
        for e in succesorList:
            if e[0] not in visited:
                curentState=e[0]

                # creeaza o lista noua nu modificam direct accumulatorul pt ca
                # in python listele sunt obiecte mutabile si se modifica in toate
                # locurile unde sunt folosite
                temp_acc = accumulator + [e[1]]
                # accumulator.append(e[1]) nu e bine asa

                solution=depthFirstSearch(problem, visited, temp_acc, curentState, ok)
                if solution is not None:
                    return solution
        return None

def breadthFirstSearch(problem: SearchProblem):
    """Search the shallowest nodes in the search tree first."""
    visited = set()
    queue = Queue()
    queue.push((problem.getStartState(), []))

    while not queue.isEmpty():
        currentState, actions = queue.pop()

        if currentState in visited:
            continue

        visited.add(currentState)

        if problem.isGoalState(currentState):
            return actions

        successors = problem.getSuccessors(currentState)

        for nextState, action, _ in successors:
            if nextState not in visited:
                queue.push((nextState, actions + [action]))

    return []  # Return an empty list if no solution is found
    #util.raiseNotDefined()

def uniformCostSearch(problem: SearchProblem):
    """Search the node of least total cost first."""
    visited = set()
    priorityQueue = util.PriorityQueue()
    priorityQueue.push((problem.getStartState(), [], 0), 0)

    while not priorityQueue.isEmpty():
        currentState, actions, totalCost = priorityQueue.pop()

        if currentState in visited:
            continue

        visited.add(currentState)

        if problem.isGoalState(currentState):
            return actions

        successors = problem.getSuccessors(currentState)

        for nextState, action, stepCost in successors:
            if nextState not in visited:
                priorityQueue.push((nextState, actions + [action], totalCost + stepCost), totalCost + stepCost)

    return []  # Return an empty list if no solution is found

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """Search the node that has the lowest combined cost and heuristic first."""
    startState = problem.getStartState()
    priorityQueue = util.PriorityQueue()
    visited = set()

    # Each element in the priority queue is a tuple: (state, actions, cost)
    priorityQueue.push((startState, [], 0), 0)

    while not priorityQueue.isEmpty():
        currentState, actions, cost = priorityQueue.pop()

        if currentState in visited:
            continue

        visited.add(currentState)

        if problem.isGoalState(currentState):
            return actions

        successors = problem.getSuccessors(currentState)

        for nextState, action, stepCost in successors:
            if nextState not in visited:
                newActions = actions + [action]
                newCost = cost + stepCost
                priority = newCost + heuristic(nextState, problem)
                priorityQueue.push((nextState, newActions, newCost), priority)

    return []  # Return an empty list if no solution is found

# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
