from multiprocessing import Process, Value, Array, Manager
import time


class Hello:
    def __init__(self):
        # Shared memory - status_code is "i" (integer value)
        self.status_code = Value("i", 999)
        self.manager = Manager()
        self.ws_log = self.manager.list()

    def running_job(self, timeout=5):
        for i in range(timeout):
            time.sleep(1)
            print(f"running_job: ... {i}/{timeout}")
            self.ws_log.append(f"running_job: ... {i}/{timeout}")
        self.status_code.value = 0

    def waiting_job(self):
        while self.status_code.value == 999:
            time.sleep(1)
            print("waiting_job: ...")
        print(f"waiting_job: status_code is now {self.status_code.value}")


if __name__ == "__main__":

    h = Hello()

    procs = []
    proc = Process(target=h.waiting_job)
    procs.append(proc)
    proc.start()

    proc = Process(target=h.running_job)
    procs.append(proc)
    proc.start()

    # Complete the processes
    print("CheckPt: Completing the process")
    for proc in procs:
        proc.join()

    print(f"CheckPt: Completed with status_code: {h.status_code.value}")

    print(h.ws_log)
