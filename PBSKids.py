# -*- coding: utf-8 -*-

channel_map = {"live": [0, 1], "odd_squad": [0, 0], "daniel_tiger": [1, 1], "wild_kratts": [1, 0]}


class PBSKids(roku.Roku):
    def __init__(self, **kwargs):
        self.roku = roku.Roku(**kwargs)
        self.pbs_kids = next(a for a in self.roku.apps if a.name == "PBS KIDS")

    def zero(self):
        for _ in range(10):
            self.left()
            self.down()

    def live_home(self):
        self.back()
        self.zero()

    def home(self):
        self.back(2)
        self.zero()

    def sleep(self, sleep_time=0.1):
        time.sleep(sleep_time)

    def launch(self):
        self.pbs_kids.launch()
        time.sleep(5)
        self.zero()

    def play_show(self, show):
        self.launch()
        for _ in range(channel_map[show][0]):
            self.roku.right()
        for _ in range(channel_map[show][1]):
            self.roku.up()
        time.sleep(2)
        self.select(2)

    # Practical Pressing

    def left(self):
        self.roku.left()
        self.sleep()

    def right(self):
        self.roku.right()
        self.sleep()

    def up(self):
        self.roku.up()
        self.sleep()

    def down(self):
        self.roku.down()
        self.sleep()

    def select(self, times=1):
        for _ in range(times):
            self.roku.select()
            self.sleep(2)

    def back(self, times=1):
        cmd = getattr(self.roku, "back")
        for _ in range(times):
            self.roku.select()
            self.sleep(2)