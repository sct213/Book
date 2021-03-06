/*:
    클로저
 */
/*
 1. 클로저는 두 가지로 이루어진 객체입니다.
    또 다른 하나는 내부 함수가 만들어진 주변 환경입니다.
 2. 클로저는 외부 함수 내에서 내부 함수를 반환하고,
    내부 함수가 외부 함수의 지역 변수나 상수를 참조할 때 만들어집니다.
 
 요약 : "클로저란 내부 함수와 내부 함수에 영향을 미치는 주변 환경(Context)을 모두 포함한 객체이다."
 */
// 주변 환경(Context)이라는 것은 내부 함수에서 참조하는 모든 외부 변수나 상수의 값, 그리고 내부 함수에서 참조하는 다른 객체까지를 말한다.
//: 즉, 클로저란 내부 함수와 이 함수를 둘러싼 주변 객체들의 값을 함께 의미하는 것

// 클로저 = 내부 함수 + 함수의 주변 환경
func basic(param: Int) -> (Int) -> Int {
    let value = param + 20
    
    func append(add: Int) -> Int {
        return value + add
    }
    
    return append
}

let result = basic(param: 10)

func append(add: Int) -> Int {
    return 30 + add
}

// 예제의 호출 구문을 달리하면 서로 다른 환경을 저장하는 클로저들이 만들어진다.
let result1 = basic(param: 10)
let result2 = basic(param: 5)

// 이때, result1과 result2에 저장된 클로저를 정의 구문으로 나타내면 다음과 같다.
// result1  에 할당된 클로저 정의
func append1(add: Int) -> Int {
    return 30 + add
}

// result2에 할당된 클로저 정의
func append2(add: Int) -> Int {
    return 25 + add
}

// 이처럼 외부 함수에서 정의된 객체가 만약 내부 함수에서도 참조되고 있고, 이 내부 함수가 반환되어 참조가 유지되고 있는 상태라면 클로저에 의해 내부 함수 주변의 지역 변수나 상수도 함께 저장된다.
// 정확히는 지역 변수의 값이 '저장'되는 것이라고 할 수 있다. (값이 캡처되었다.)

// 스위프트에서 클로저는 일회용 함수를 작성할 수 있는 구문이다.(익명 함수)

//MARK: - 클로저 표현식
// 일반 함수의 선언 형식에서 func키워드와 함수명을 제외한 나머지 부분
// 일반적인 함수 정의라면 반환 타입이 표현된 다음에 실행 블록의 시작을 나타내는 중괄호가 와야 하지만, 클로저 표현식에서는 시작 부분에서 이미 중괄호가 선언된 상태이므로 중괄호 대신 in 키워드를 사용하여 실행 블록의 시작을 표현합니다.
/*
 ````
 { (매개변수) -> 반환 타입 in
    실행할 구문
 }
 */

//// 반환값이 없는 경우의 클로저
//{ () -> Void in
//    print("클로저가 실행됩니다")
//}

// 작성된 클로저 표현식은 그 자체로 함수라고 할 수 있습니다.

// 첫번째 방법 - 일급 함수로서의 특성을 활용한 상수나 변수에 표현식 할당
let f = { () -> Void in
    print("클로저가 실행됩니다.")
}
f()
// 위 구문은 실제로 함수의 인자값으로 전달된 클로저 표현식이 함수 내에서 실행되는 방식.
// 상수 f에 클로저 표현식으로 작성된 함수 전체가 할당되고, 이 상수에 함수 호출 연산자를 추가함으로써 클로저 표현식이 실행된다.

// 두번째 방법 - 클로저를 직접 실행
({ () -> Void in
    print("클로저가 실행됩니다.")
})()
// 클로저 표현식을 할당받을 상수마저 생략하고 작성하는 구문
// 클로져 표현식 전체를 소괄호로 감싸고, 여기에 함수 호출 연산자를 붙인다.
// 클로저 표현식 전체를 소괄호로 감싸지 않으면 컴파일러에서는 이 구문을 클로저 표현식의 정의가 아니라 그 실행값을 변수나 상수에 할당하려는 의도로 해석하여 오류를 발생시킴

// 매개변수가 있는 형태의 클로저 표현식
// 함수를 선언할 때처럼 매개변수와 함수의 이름만 적절히 작성
let c = { (s1: Int, s2: String) -> Void in
    print("s1: \(s1), s2: \(s2)")
}
c(1, "Closure")
// 이 매개변수는 클로저의 실행블록 내부에서 상수로 선언되므로 실행 구문의 범위 내에서 사용할 수 있다.

// 보다 간결히 작성
({ (s1: Int, s2: String) -> Void in
    print("s1: \(s1), s2: \(s2)")
})(1, "closure")
// 문법을 간결하게 작성하면 할수록 가독성이 떨어지는 결과를 가져옴.
// 클로저의 경우 이러한 특성이 매우 두드러지므로 작성 시 간결성과 가독성의 비율을 고려할 것


//MARK: - 클로저 표현식과 경량 문법

var value = [1, 9, 5, 7, 3, 2]

// 정렬 기준이 되는 함수
func order(s1: Int, s2: Int) -> Bool {
    if s1 > s2 {
        return true
    } else {
        return false
    }
}

// 작성된 함수는 입력된 두 인자값을 크기 비교하여 첫번째 인자값이 크면 true, 이외는 false를 반환. true가 반환되면 sort메서드는 배열에서 두 인자값의 위치를 변경하지 않는다.
// 반대로 false라면 두 인자값의 위치를 변경ㄷ
value.sort(by: order)

// order를 클로저 표현식으로 작성
let nn = {
    (s1: Int, s2: Int) -> Bool in
    if s1 > s2 {
        return true
    } else {
        return false
    }
}
// 이 클로저는 sort메소드의 인자값으로 사용 가능
value.sort(by: {
            (s1: Int, s2: Int) -> Bool in
    if s1 > s2 {
        return true
    } else {
        return false
    }
})

// 앞선 구문의 요약
let tt = { (s1: Int, s2: Int) -> Bool in
    return s1 > s2
}

// 간단한 코드는 한줄로 표현
value.sort(by: { (s1: Int, s2: Int) -> Bool in return s1 > s2})

// 스위프트에서 제공하는 문법을 활용한 클로저 표현식 간결화
// 클로저 표현식은 반환값의 타입을 생략할 수 있다.
// 반환 타입을 생략하면 컴파일러는 클로저 표현식의 구문을 해석하여 반환값을 찾고, 이 값의 타입을 추론하여 클로저의 반환 타입을 정의함

// -> Bool 반환값 표현을 생략
let tt2 = { (s1: Int, s2: Int) in
    return s1 > s2
}

// 위 예제가 sort 메소드의 인자값으로 사용된 모습
value.sort(by: { (s1: Int, s2: Int) in return s1 > s2 })
// 이 정도도 충분히 간결하지만, 더 줄일 수 있다.
// 클로저 표현식에서 생략할 수 있는 또 하나의 부분이 바로 매개변수의 타입 정의 부분
// 생략된 매개변수의 타입은 컴파일러가 실제로 대입되는 값을 기반으로 추론함
value.sort(by:{ s1, s2 in return s1 > s2 })

// 매개변수의 타입 어노테이션이 생략되면서 매개변수를 감싸고 있던 괄호도 함께 생략됨
// 이제 이 클로저 표현식은 두 부분으로만 구성되는데, 키워드 in을 기준으로 하여 매개변수 정의와 실행 구문으로 나뉜다.

// 이제는 매개변수마저 생략하자.
// 매개변수가 생략되면 매개변수명 대신 $0, $1, $2... 와 같은 이름으로 할당된 내부 상수를 이용할 수 있다.
// 첫번째 인자값이 $0에, 두번째 인자값이 $1에 할당되는 방식이다.(s1 대신 $0, s2 대신 $1이 사용된다.

// 매개변수가 생략되면 남는 실행 구문. 이 때문에 in 키워드로 기존처럼 실행 구문과 클로저 선언 부분을 분리할 필요가 없어지므로 in 키워드 역시 생략할 수 있다.
// { return $0 > $1 }
// 이것은 입력받은 인자값을 순서대로 비교하여 결과값을 반환하게 만든다. 어차피 Bool 값을 반환할 것을 컴파일러가 알고 있으며, 비교 연산자의 결과가 if구문과 같은 조건문에서 사용되지 않은 점 역시 컴파일러가 반환 타입을 추론할 수 있는 단서가 되므로, return 구문까지 생략된다.
value.sort(by: { $0 > $1 })

// 클로저 표현식보다 더 간결하게 표현하는 연산자 함수를 이용한 방법
value.sort(by: > )


//MARK: - 트레일링 클로저(Trailing Closure)

// 정의: 함수의 마지막 인자값이 클로저일 때, 이를 인자값 형식으로 작성하는 대신 함수의 뒤에 꼬리처럼 붙일 수 있는 문법, 이때 인자 레이블은 생략된다.
// 주의: 이같은 문법이 함수의 마지막 인자값에만 적용된다는 것. 클로저를 인자값으로 받더라도 마지막 인자값이 아니라면 적용할 수 없다. 만약 인자값이 하나라면, 이는 첫번째이자 마지막 인자값이므로 트레일링 클로저 문법을 사용할 수 있다.
// 클로저를 다른 함수의 인자값으로 전달할 때에는 자칫 가독성을 해치는 복잡한 구문이 만들어질 수 있다. 여러줄로 작성된 클로저가 소괄호 내에 들어가면 아무리 깔끔하게 작성한다 하더라도 전체 코드를 알아보기가 쉽지 않음.
value.sort(by: {(s1, s2) in
    return s1 > s2
})

// 스위프트는 인자값으로 클로저를 전달하는 특수한 상황에서 문법을 변형할 수 있도록 지원하는데, 바로 트레일링 클로저 문법이다.

value.sort() { (s1, s2) in
    return s1 > s2
}
// 달라진 점이 크게 없어 보이나, 인자값으로 사용되던 클로저가 통째로 바깥으로 빼내어진 다음, sort() 메소드 뒤쪽에 달라붙었다. 마지막 꼬리처럼.
// 이로 인해 코딩 과정에서 sort()함수를 열고 닫는 범위가 줄어들었음을 얻음

// 스위프트에서 함수의 마지막 인자값이 클로저일 때에는 트레일링 클로저 문법을 사용하는 것이 일반화 되어있다.

// 인자값이 하나일 경우, 트레일링 클로저 문법은 조금 더 변화 가능한 여지가 있다.
value.sort { (s1, s2) in return s1 > s2 }
// 이번에는 괄호가 사라졌다.
// 인자값이 하나일 때에는 마지막 인자값 뿐만 아니라 인자값을 넣어주기 위한 괄호 부분도 생략 가능

// 만약 인자값이 여러 개라면, 무작정 괄호를 생략해서는 -안된다.
func divide(base: Int, success s: () -> Void) -> Int {
    defer {
        s() // 성공 함수를 실행
    }
    return 100 / base
}

// 마지막 인자에 클로저를 넣을 수 있으므로 위 함수는 트레일링 클로저를 사용할 수 있다.

// 이때 트레일링 클로저 문법을 사용하여 divide함수를 호출하는 구문.
divide(base: 100) { () in
    print("연산에 성공했습니다.")
}
// divide 함수는 첫번째 인자값으로 Int 타입의 정수를 입력받아야 하므로, 괄호를 완전히 생략할 수는 없습니다. 대신 두번째 인자값에 대한 레이블인 'success:'는 생략 가능하므로, 읽견 'base:'라는 인자 레이블을 하나만 가지는 함수처럼 보이기도 합니다.
// 중요한 것은 인자값이 하나 이상이라면 괄호를 생략할 수 없다.

// 마지막 인자값이 클로저일 때. 라는 사용 조건 때문에 연어이 두 개의 클로저 인자값이 사용될 경우 트레일링 클로저를 사용할 수 없습니다.

// divide 함수에 함수 타입의 매개변수를 하나 더 추가. - 실패 시 구문
func divide(base: Int, success s: () -> Void, fail f: () -> Void) -> Int {
    guard base != 0 else {
        f() // 실패 함수 실행
        return 0
    }
    
    defer {
        s() // 성공 함수 실행
    }
    return 100 / base
}

// 마지막 두 개의 인자값은 모두 함수 타입이지만, 트레일링 클로저 문법은 마지막 인자값에만 적용할 수 있기 때문에 함수 호출시 두번째 인자값인 success 부분은 다음과 같이 작성
divide(base: 100, success: { () in
    print("연산 성공.")
}) { () in
    print("연산 실패.")
}

// 아래와 같은 코드는 불가함.
//divide(base: 100) { () in print("연산 성공") } { () in print("연산 실패")}


//MARK: - @escaping과 @autoescape

 /*
    # @escaping
        인자값으로 전달된 클로저를 저장해 두었다가, 나중에 다른 곳에서도 실행하는 역할
 */
func callback(fn: () -> Void) {
    let f = fn // 클로저를 상수 f에 대입
    f() // 대입된 클로저 실행
}

// ! 스위프트에서 함수의 인자값으로 전달된 클로저는 기본적으로 "탈출불가(non-escape)"의 성격을 가진다. 이는 해당 클로저를 1. 함수 내에서 2. 직접 실행을 위해서만 사용해야 하는 것을 의미
// ! 이 때문에 함수 내부라 할지라도 변수나 상수에 대입할 수 없다. 변수나 상수에 대입하는 것을 허용한다면 내부 함수를 통한 캡처 기능을 이용하여 클로저가 함수 바깥으로 탈출할 수 있기 때문.
// ! 여기서 말하는 탈출이란, 함수 내부 범위를 벗어나서 실행되는 것을 의미

// ! 동일한 의미에서, 인자값으로 전달된 클로저는 중첩된 내부 함수에서 사용할 수 없습니다.
// ! 내부 함수에서 사용할 수 있도록 허용할 경우, 이 역시 컨텍스트(Context)의 캡처를 통해 탈출될 수 있기 때문입니다.

// 다음 예제를 실행하면 오류가 발생
//func callback(fn: () -> Void) {
//    func innerCallback() {
//        fn()
//    }
//}

// @escaping 속성은 클로저를 변수나 상수에 대입하거나 중첩 함수 내부에서 사용해야 할 경우 사용
// 이 속성을 클로저에 붙여주면, 해당 클로저는 탈출이 가능한 인자값으로 설정된다.

// @escaping 속성을 추구한 함수.
// 위치: 함수 타입 앞에 넣어주기.
func _callback(fn: @escaping () -> Void) {
    let f = fn // 클로저를 상수에 대입
    f() // 대입된 클로저 실행
}

_callback {
    print("Closure가 실행되었습니다.")
}
// 입력된 클로저는 변수나 상수에 정상적으로 할당될 뿐만 아니라, 중첩된 내부 함수에 사용할 수 있으며, 함수 바깥으로 전달할 수도 있습니다. 말 그대로 탈출 가능한 클로저

// 인자값으로 전달되는 클로저의 기본 속성이 탈출불가하도록 설정된 이유
// 클로저의 기본 속성을 탈출불가하게 관리함으로써 얻어지는 가장 큰 이점은 컴파일러가 코드를 최적화하는 과정에서의 성능향상입니다.
// 해당 클로저가 탈출할 수 없다는 것은 컴파일러가 더 이상 메모리 관리상의 지저분한 일들에 관여할 필요가 없다는 뜻이다.

// 또한, 탈출불가 클로저 내에서는 self키워드를 사용할 수 있습니다.
// 이 클로저는 해당 함수가 끝나서 리턴되기 전에 호출될 것이 명확하기 때문.
// self에 대한 약한 참조를 사용해야할 필요가 없습니다.

//MARK: - @autoclosure
// 인자값으로 전달된 일반 구문이나 함수 등을 클로저로 래핑하는 역할을 한다.
// 이 속성이 붙어 있을 경우, 일반 구문을 인자값으로 넣더라도 컴파일러가 알아서 클로저로 만들어서 사용한다.
// 이 속성을 적용하면 인자값을 '{}' 형태가 아니라 '()'형태로 사용할 수 있다는 장점이 있다.
// 인자값을 직접 클로저 형식으로 넣어줄 필요가 없기 때문.
// 이는 코드를 조금 더 이해하기 쉬운 형태로 만들어준다.

func condition(stmt: () -> Bool) {
    if stmt() == true {
        print("결과가 참입니다.")
    } else {
        print("결과가 거짓입니다.")
    }
}

// 함수 condition(stmt:)는 참/거짓을 반환하는 클로저를 인자값으로 전달받고 그 결과값을 문장으로 출력해 주는 역할을 한다.

// 실행방법 1 : 일반 구문
condition(stmt: {
    4 > 2
})

// 실행방법 2 : 클로저 구문
condition {
    4 > 2
}

// STEP 1 : 경량화되지 않은 클로저 전체 구문
condition { () -> Bool in
    return (4 > 2)
}

// STEP 2 : 클로저 타입 선언 생략
condition {
    return (4 > 2)
}

// STEP 3 : 클로저 반환구문 생략
condition {
    4 > 2
}


// @autoclosure속성
func condition(stmt: @autoclosure () -> Bool) {
    if stmt() == true {
        print("결과는 참")
    } else {
        print("결과가 거짓")
    }
}

// @autoclosure를 적용하면 반드시 위와 같은 구문으로 호출해야 함.
// @autoclosure 속성의 영향으로, 더이상 일반 클로저를 인자값으로 사용할 수 없기 때문.
// 같은 이유로 클로저일 때 사용할 수 있는 트레일링 클로저 구문도 @autoclosure속성이 붙으면 사용 불가

// 실행방법
condition(stmt: (4 > 2))

// 핵심은 클로저가 아니라 그 안에 들어가는 내용만 인자값으로 넣어줄 뿐이다.
// 이렇게 전달된 인자값은 컴파일러가 자동으로 클로저 형태로 감싸 처리해준다.
// 하지만, 인자값으로 클로저를 넣는 것보다 훨씬 자연스럽고 익숙한 구문으로 사용할 수 있다.

// @autoclosure속성의 개념 하나는 '지연된 실행'

// 빈 배열 정의
var arrs = [String]()

func addVars(fn: @autoclosure () -> Void) {
    // 배열 요소를 3개까지 추가하여 초기화
    arrs = Array(repeating: "", count: 3)
    // 인자값으로 전달된 클로저 실행
    fn()
}
// 구문 1: 아래 구문은 오류가 발생함
// 초기화만 되어 있는 배열의 상태에서 addVars(fn:)함수가 실행되기 전까지 이 함수의 인덱스는 0까지밖에 없음. 이 때문에 마지막에 작성된 arrs.insert(at:) 메소드는 오류가 발생.
// 마지막 구문의 내용은 arrs 배열의 두번째 인덱스 위치에 "KR" 값을 입력하는 것인데, 아직 배열의 인덱스가 그만큼 확장되어 있지 않기 때문.
//arrs.insert("KR", at: 1)

// 구문 2: 오류가 발생하지 않음
addVars(fn: arrs.insert("KR", at: 1))

// 지연된 실행때문에 오류가 발생하지 않은 것.
// 원래 구문은 작성하는 순간에 실행되는 것이지만, 함수 내에 작성된 구문은 함수가 실행되기 전까지는 실행되지 않는다.
// @autoclosure 속성이 부여된 인자값은 보기엔 일반 구문 형태이지만 컴파일러에 의해 클로저. 즉 함수로 감싸기지 때문에 위와 같이 작성해도 addVars(fn:) 함수 실행 전까지는 실행되지 않으며, 해당 구문이 실행될 때에는 이미 배열의 인덱스가 확장된 후 이므로 오류가 발생하지 않은 것.

// 정리 : @autoclosure 속성이 인자값에 부여되면 해당 인자값은 컴파일러에 의해 클로저로 자동 래핑된다. 이 때문에 '()' 형식의 일반값을 인자값으로 사용해야 함.
//      또한, 인자값은 코드에 작성된 시점이 아니라 해당 클로저가 실행되는 시점에 맞추어 실행된다.
//      이를 지연된 실행이라고 부르며 @autoclosure 속성이 가지는 주요한 특징 중 하나이다.





















