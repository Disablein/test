//                       задание 1
// function a(number) {
//     let znak;
//     if (number > 0) {
//         znak = "Число положительное";
//     } else if (number < 0) {
//         znak = "Число отрицательно";
//     } else {
//         znak = "Число равно нулю";
//     }

//     let chetnost;
//     if (number % 2 == 0) {
//         chetnost = "Число четное";
//     } else {
//         chetnost = "Число нечетное";
//     }
//     console.log(`Число ${number}: ${znak}, ${chetnost}`);
// }
// a(5);
// a(-4);
// a(0);

//                      Задание 2
// const numbers = [4, 8, 15, 23, 42];
// let sum = 0;
// let max = numbers[0];
// const morethan10 = [];
// for (let i = 0; i < numbers.length; i++) {
// sum = sum + numbers[i];
// if (numbers[i] > max) {
//     max = numbers[i]
// }
// if (numbers[i] > 10) {
//     morethan10.push(numbers[i]);
// }
// }
// console.log('Сумма:', sum);
// console.log('Максимум:', max);
// console.log('> 10:', morethan10);

//                  Задание 3
// const students = [
//     {name: 'Анна', grade: 5},
//     {name: 'Борис', grade: 3},
//     {name: 'Вика', grade: 4},
//     {name: 'Глеб', grade: 2},
//     {name: 'Дарья', grade: 5},
// ];
// function studentThresholdGrade(students, mingrade) {
//     return students.filter(student => student.grade > mingrade);
// }
// function averageGrade(students) {
//     const total = students.reduce((acc, student) => acc + student.grade, 0);
//     return total / students.length;
// }
// console.log('Оценка больше 3:', studentThresholdGrade(students, 3));
// console.log('Средняя оценка:', averageGrade(students));

//                  Задание 4
// <!DOCTYPE html>
// <html lang="en">
// <head>
//     <meta charset="UTF-8">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
// </head>
// <body>
//     <script>
//     function guessnumber() {
//     const randomnumber = Math.floor(Math.random() * 10) + 1;
//     let guess;

//     while (guess !== randomnumber) {
//     guess = Number(prompt('Угадай число от 1 до 10:'));
//     if (guess == randomnumber) {
//         alert(`Угадал. Это ${randomnumber}`);
//     } else if (guess < randomnumber) {
//         alert('Загаданное число больше этого');
//     } else {
//         alert('Загаданное число меньше этого')
//     }
// }
// }
// guessnumber()

// </script>
// </body>
// </html>










