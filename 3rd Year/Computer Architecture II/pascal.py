from timeit import default_timer as timer

procedure_calls = 0
window_depth = 0
max_depth = 0
registers_used = 2
nregisters = 0
overflows = 0
underflows = 0


def underflow():
    global underflows, registers_used 
    if registers_used > 2: registers_used -= 1  
    else:
        underflows += 1
  
def overflow(overflow_param):
    global window_depth, max_depth, overflows, registers_used
    if registers_used < (nregisters-overflow_param): registers_used += 1
    else: overflows += 1
    if window_depth > max_depth: max_depth = window_depth


def compute_pascal(row, position, overflow_modify_param):
    global procedure_calls, window_depth, max_depth, overflows, underflows, registers_used
    procedure_calls += 1
    window_depth += 1
    overflow(overflow_modify_param)
    answer = 0 
    if position == 1:
        window_depth -= 1
        underflow()
        return 1

    elif position == row:
        window_depth -= 1
        underflow()
        return 1

    else:
        answer = compute_pascal(row - 1, position, overflow_modify_param) + compute_pascal(row - 1, position - 1, overflow_modify_param) 
        window_depth -= 1
        underflow()
        return answer


if __name__ == "__main__":
    time = 0.0

    nregisters = int(input("Registers : "))
    overflow_modify_param = int(input("Overflow param: "))
    print("Pascal(30, 20) with " + str(nregisters) + " Registers " + "\n")
    start_time = timer()
    for t in range(5):
        ans = 0
        overflows = 0
        underflows = 0
        registers_used = 2
        procedure_calls = 0
        window_depth = 0
        max_depth = 0
        ans = compute_pascal(30, 20, overflow_modify_param)
    end_time = timer()
    total_time = (end_time - start_time) / 5

    print("Procedural Calls is " + str(procedure_calls) + "\n")
    print("Max Depth is " + str(max_depth) + "\n")
    print("Overflows is " + str(overflows) + "\n")
    print("Underflows is " + str(underflows) + "\n")
    print("Average Time is " + str(total_time) + "\n")
    print("Answer is " + str(ans) + "\n")