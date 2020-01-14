# Chapter 01
## 객체, 설계
### 01. 티켓 판매 어플리케이션 구현하기

소극장 어플리케이션. 
초대장을 받은 관람객과 그렇지 않은 관람객이 존재. 

``` swift
class Invitation {
    private(set) var when: Date?
}

```


``` swift
class Ticket {
    private(set) var fee: Int = 8500
}
```

관람객 객체 
``` swift
class Audience {
    private(set) var bag: Bag
    
    init(bag: Bag) {
        self.bag = bag
    }
}
```

#### 관람객 클래스가 갖는 Bag 클래스

초대장을 받은 관람객 : 초대장 + 현금
초대장을 받지 않은 관람객 : 현금

``` swift

class Bag {
    private var amount: Int = 0
    private var invitation: Invitation?
    private(set) var ticket: Ticket?
    
    convenience init(amount: Int) {
        self.init(amount: amount, invitation: nil)
    }
    
    init(amount: Int, invitation: Invitation?) {
        self.amount = amount
        self.invitation = invitation
    }
    
    func hasTicket() -> Bool {
        return ticket != nil
    }
    
    func hasInvitation() -> Bool {
        return invitation != nil
    }
    
    func plusAmount(amount: Int) {
        self.amount += amount
    }
    
    func minusAmount(amount: Int) {
        self.amount -= amount
    }
    
    func setTicket(ticket: Ticket) {
        self.ticket = ticket
    }
    
}	
```

매표소 클래스 

``` swift
class TicketOffice {
    private(set) var amount: Int
    private(set) var tickets: [Ticket]
    
    init(amount: Int, tickets: [Ticket]) {
        self.amount = amount
        self.tickets = tickets
    }
    
    func getTicket() -> Ticket? {
        return tickets.first
    }
    
    func plusAmount(amount: Int) {
        self.amount += amount
    }
    
    func minusAmount(amount: Int) {
        self.amount -= amount
    }
}
```

티켓 판매원 클래스
``` swift
class TicketSeller {
    private(set) var ticketOffice: TicketOffice
    
    init(ticketOffice: TicketOffice) {
        self.ticketOffice = ticketOffice
    }
}


```

영화관 클래스
``` swift
class Theater {
    private(set) var ticketSeller: TicketSeller
    
    init(ticketSeller: TicketSeller) {
        self.ticketSeller = ticketSeller
    }
    
    func enter(audience: Audience) {
        if audience.bag.hasInvitation() {
            guard let ticket = ticketSeller.ticketOffice.getTicket() else { return }
            audience.bag.minusAmount(amount: ticket.fee)
            ticketSeller.ticketOffice.plusAmount(amount: ticket.fee)
            audience.bag.setTicket(ticket: ticket)
        } else {
            guard let ticket = ticketSeller.ticketOffice.getTicket() else { return }
            audience.bag.minusAmount(amount: ticket.fee)
            ticketSeller.ticketOffice.plusAmount(amount: ticket.fee)
            audience.bag.setTicket(ticket: ticket)
        }
    }
}
```
Enter 메소드 :  소극장은 먼저 관람객의 가방을 확인. 초대장이 있다면 판매원에게서 받은 티켓을 가방안에 넣어준다. 가방안에 티켓이 없다면 가방에서 티켓 금액만큼 차감한 후 매표소 금액을 증가. 


