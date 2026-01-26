import {Car, displayCarInfo, morePowerfulCar} from './car';

const myCar: Car = {
    make: {
        name: 'Lamborghini Automobili S.p.A',
        country: 'Italy',
        foundationYear: 1963
    },
    model: 'Centenario LP 770-4',
    year: 2017,
    doors: 2,
    isElectric: false,
    horsepower: 770,
    torque: 720,
    price: 2050000,
    mileage: 10
}

const myCar2: Car = {
    make: {
        name: 'Hennessey Performance Engineering',
        country: 'United States of America',
        foundationYear: 1991
    },
    model: 'Camaro "The Exorcist"',
    year: 2021,
    doors: 2,
    isElectric: false,
    horsepower: 1000,
    torque: 1310,
    price: 200000,
    mileage: 14
}

displayCarInfo(morePowerfulCar(myCar, myCar2));