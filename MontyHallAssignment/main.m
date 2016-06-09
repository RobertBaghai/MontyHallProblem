//
//  main.m
//  MontyHallAssignment
//
//  Created by Robert Baghai on 6/9/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import "Door.h"

#define TOTAL_GAMES 1000000

/*
 ****THE MONTY HALL PROBLEM****
 From Wikipedia: Supposed you're on a game show, and you're given the choice of three doors: Behind one door is a car; behind the others, goats. You pick a door, say No.1, and the host, who knows what's behind the doors, opens another door, say No.3, which has a goat. He then says to you, "Do you want to pick door No.2?". Is it to your advantage to switch your choice?
 */

void assignRandomPrizesToDoorsInArray(NSArray *doorsArray);
Door* chooseRandomDoorFromArray (NSArray *doorsArray);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        unsigned int winsBySwitching = 0, i = 0;
        
        Door *doorOne       = [[Door alloc] init];
        Door *doorTwo       = [[Door alloc] init];
        Door *doorThree     = [[Door alloc] init];
        NSArray *doorsArray = @[doorOne, doorTwo, doorThree];
        
        for (i = 0; i < TOTAL_GAMES; i++) {
            
            assignRandomPrizesToDoorsInArray(doorsArray);
            Door *chosenDoor = chooseRandomDoorFromArray(doorsArray);
            
            //if the door we randomly selected has a prize of a goat then logically we would win if we were to switch our choice
            if ([chosenDoor.prize isEqualToString:@"Goat"]) {
                winsBySwitching++;
            }
        }
        
        NSLog(@"\n\nAfter %u games, I won %u by switching. %.2f%% of the time I won by switching. Therefore it is to my advantage to switch.\n\n", TOTAL_GAMES, winsBySwitching, (float)winsBySwitching * 100.0 / (float) i);
    }
    return 0;
}

/*
 *Randomly assign a prize "Goat" or "Car" to the doors in the array
 *There can only be one car in the array at any given time
 *if we reach the end of the array and a car prize has not been created, make the door at the last index have a Car prize
 */
void assignRandomPrizesToDoorsInArray(NSArray *doorsArray) {
    BOOL carExists = NO;
    
    for (int i = 0; i < doorsArray.count; i++) {
        int random = arc4random_uniform(2);
        Door *door = doorsArray[i];
        
        if (random == 0 && carExists == NO) {
            door.prize = @"Car";
            carExists = YES;
        } else if (i == doorsArray.count - 1 && carExists == NO) {
            door.prize = @"Car";
            carExists = YES;
        } else {
            door.prize = @"Goat";
        }
    }
    
}

/*
 *Randomly selects a door from the array of doors and returns that object
 */
Door* chooseRandomDoorFromArray (NSArray *doorsArray) {
    int index   = arc4random_uniform((int)doorsArray.count);
    Door *door  = doorsArray[index];
    return door;
}
