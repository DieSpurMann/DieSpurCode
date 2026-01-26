export interface Make {
    name: string;
    country: string;
    foundationYear: number;
}

export interface Vehicle {
    make: Make;
    model: string;
    year: number;
}

export interface Car extends Vehicle {
    doors: number;
    isElectric: boolean;
    horsepower: number;
    torque: number;
    price: number;
    mileage: number;
}

const formatter = new Intl.NumberFormat('en-US');

export function displayCarInfo(car: Car): void {
    console.log(`Car Information:
    Make: ${car.make.name}
    Model: ${car.model}
    Year: ${car.year}
    Doors: ${car.doors}
    Electric: ${car.isElectric ? 'Yes' : 'No'}
    Horsepower: ${formatter.format(car.horsepower)} hp
    Torque: ${formatter.format(car.torque)} N-m
    Price: $${formatter.format(car.price)}
    Mileage: ${formatter.format(car.mileage)} MPG`);
}

export function morePowerfulCar(car1: Car, car2: Car): Car {
    return car1.horsepower > car2.horsepower ? car1 : car2;
}