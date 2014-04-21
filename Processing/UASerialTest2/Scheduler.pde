// scheduler

// list of patterns in order
// pattern index

class Scheduler {

    // Patterns are scheduled to run for a random amount
    // of minutes between these two numbers

    int MINIMUM_PATTERN_DURATION = 30;
    int MAXIMUM_PATTERN_DURATION = 60;

    Pattern[] dayPatterns = new Pattern[] {

        new FadePattern(),
        new PuddlePattern()

    };

    Pattern[] nightPatterns = new Pattern[] {

        new FadePattern(),
        new PuddlePattern(),
        new SinePattern()

    };

    int patternIndex = -1;

    int currentPatternDuration;
    int currentPatternStarted;

    Pattern[] currentPatternList;

    Scheduler() {

        currentPatternList = dayPatterns;
        nextPattern();

    }

    void update() {



    }

    void nextPattern() {

        currentPatternDuration = int(random(MINIMUM_PATTERN_DURATION, MAXIMUM_PATTERN_DURATION));
        currentPatternStarted = minuteOfDay();

        patternIndex++;
        patternIndex %= currentPatternList.length;

        pattern = currentPatternList[patternIndex];

        println("Setting pattern to " + pattern);
        println("Next pattern in " + currentPatternDuration);

    }

    int minuteOfDay() {
        return hour() * 60 + minute();
    }

}