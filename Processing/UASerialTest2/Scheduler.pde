// scheduler

// list of patterns in order
// pattern index

class Scheduler {

    // Patterns are scheduled to run for a random amount
    // of minutes between these two numbers

    int MINIMUM_PATTERN_DURATION = 30;
    int MAXIMUM_PATTERN_DURATION = 60;

    // "Minute of day" at which scheduler switches over to 
    // "night mode". Since IR won't be reliable at night,
    // we provide fake input data to the patterns.

    int NIGHT_STARTS = 19 * 60; // 7PM
    int NIGHT_ENDS = 6 * 60; // 6AM

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

        if (minuteOfDay() - currentPatternStarted >= currentPatternDuration) {
            nextPattern();
        }

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
        // return hour() * 60 + minute();
        return 
    }

}