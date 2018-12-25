require 'date'

class GuardEvent
  def initialize(guardEventStr)
    date, type = guardEventStr.match(/\[(\d{4}\-\d{2}\-\d{2} \d{2}\:\d{2})\] (.+)/).captures
    @date = DateTime.parse(date)
    @minute = @date.to_time.min
    @guardId = nil
    @type = nil

    case type
    when /falls asleep/
      @type = :sleep
    when /wakes up/
      @type = :wake
    when /begins shift/
      @type = :beginsShift
      @guardId = Integer(type.match(/Guard #(\d+)/).captures[0])
    else
      puts "Invalid event message"
    end
  end

  def date
    @date
  end

  def minute
    @minute
  end

  def guardId
    @guardId
  end

  def type
    @type
  end
end

class Guard
  def initialize(guardId)
    @guardId = guardId
    @minutesAsleep = Hash.new 0
    @totalMinutesAsleep = 0
  end

  def guardId
    @guardId
  end

  def minutesAsleep
    @minutesAsleep
  end

  def getTotalMinutes
    @totalMinutesAsleep
  end

  def getMinuteMostAsleep
    highestMinuteCount = -1
    minuteMostAsleep = nil
    (0..59).each do |min|
      if @minutesAsleep[min] > highestMinuteCount
        minuteMostAsleep = min
        highestMinuteCount = @minutesAsleep[min]
      end
    end

    return minuteMostAsleep
  end

  def addSleep(minuteStart, minuteEnd)
    (minuteStart..minuteEnd - 1).each do |min|
      @minutesAsleep[min] += 1
      @totalMinutesAsleep += 1
    end
  end
end

def readGuardEvents
  guardEvents = []
  while input = gets
    guardEvents.push(GuardEvent.new(input))
  end

  guardEvents.sort_by { |obj| obj.date }
end

def recordGuards
  guardEvents = readGuardEvents()

  guardMap = {}
  sleepStart = nil
  currentGuard = nil
  guardEvents.each do |event|
    case event.type
    when :beginsShift
      currentGuard = event.guardId
      if !guardMap.key?(event.guardId)
        guardMap[event.guardId] = Guard.new(event.guardId)
      end
    when :sleep
      sleepStart = event.minute
    when :wake
      sleepEnd = event.minute
      guardMap[currentGuard].addSleep(sleepStart, sleepEnd)
    end
  end

  guardMap
end

def part1(guardMap)
  sleepiestGuard = nil
  sleepAmount = -1
  guardMap.each do |guardId, guard|
    if guard.getTotalMinutes() > sleepAmount
      sleepAmount = guard.getTotalMinutes()
      sleepiestGuard = guard
    end
  end

  minuteMostAsleep = sleepiestGuard.getMinuteMostAsleep()
  p "Sleepiest Guard is ##{sleepiestGuard.guardId}"
  p "Minutes asleep: #{sleepAmount}, Minute most asleep #{minuteMostAsleep}"
  p "Part 1 Answer: #{sleepiestGuard.guardId * minuteMostAsleep}"
end

def part2(guardMap)
  mostTimesOnSameMinute = -1
  chosenMinute = nil
  mostConsistentGuard = nil
  guardMap.each do |guardId, guard|
    minuteMostAsleep = guard.getMinuteMostAsleep()
    timesOnSameMinute = guard.minutesAsleep[minuteMostAsleep]

    if timesOnSameMinute > mostTimesOnSameMinute
      mostTimesOnSameMinute = timesOnSameMinute
      mostConsistentGuard = guard
      chosenMinute = minuteMostAsleep
    end
  end

  p "Most Consistent Guard is ##{mostConsistentGuard.guardId}"
  p "Slept #{mostTimesOnSameMinute} times during minute #{chosenMinute}"
  p "Part 2 Answer: #{mostConsistentGuard.guardId * chosenMinute}"
end

def main
  guardMap = recordGuards()
  part1(guardMap)
  part2(guardMap)
end

main
