// scheduler

// list of patterns in order
// pattern index


class Scheduler {

    // Patterns are scheduled to run for a random amount
    // of minutes between these two numbers

    int MINIMUM_PATTERN_DURATION = 5;// 30;
    int MAXIMUM_PATTERN_DURATION = 15;// 60;

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
    int lastMinute;

    int currentPatternDuration;
    int currentPatternStarted;

    Pattern[] currentPatternList;


    Scheduler() {
          
        int m = minuteOfDay();
        lastMinute = m;

        if (isNight(m)) {
            currentPatternList = nightPatterns;
            inputFaker.start();
        } else { 
            currentPatternList = dayPatterns;
        }

        nextPattern();

    }

    void update() {

        weather.update();

        int[] sunrise = int(splitTokens(weather.getSunrise(),": "));
        NIGHT_ENDS = sunrise[0] * 60 + sunrise[1];

        int[] sunset = int(splitTokens(weather.getSunset(),": "));
        NIGHT_STARTS = (12+ sunset[0]) * 60 + sunset[1];

        int m = minuteOfDay();

        // from day to night
        if (isNight(m) && !isNight(lastMinute)) {
            println("Switching to night patterns.");
            inputFaker.start();
            nextPattern();
        }

        // from night to day
        else if (!isNight(m) && isNight(lastMinute)) {
            println("Switching to day patterns.");
            inputFaker.stop();
            nextPattern();
        }

        // current pattern expires
        else if (m - currentPatternStarted >= currentPatternDuration) {
            nextPattern();
        }

        lastMinute = m;

    }

    boolean isNight(int m) {
        return m < NIGHT_ENDS || m > NIGHT_STARTS;
    }

    void nextPattern() {

        int m = minuteOfDay();

        currentPatternList = isNight(m) ? nightPatterns : dayPatterns;

        currentPatternDuration = int(random(MINIMUM_PATTERN_DURATION, MAXIMUM_PATTERN_DURATION));
        currentPatternStarted = m;

        patternIndex++;
        patternIndex %= currentPatternList.length;

        pattern = currentPatternList[patternIndex];

        println("Setting pattern to " + pattern);
        println("Next pattern in " + currentPatternDuration);

        println("Night starts @ " + NIGHT_STARTS);
        println("Night ends @ " + NIGHT_ENDS);

    }

    int minuteOfDay() {
        return hour() * 60 + minute();
        
        // use this line if you want to simulate time moving faster
        // return hour() * 3600 + minute() * 60 + second();
    }

}
