# Chapter 01
## 객체, 설계
### 01. 티켓 판매 어플리케이션 구현하기

소극장 어플리케이션. 
초대장을 받은 관람객과 그렇지 않은 관람객

``` java
// 초대장
public class Invitation {
    private LocalDateTime when;
}
```

``` java
// 티켓
public class Ticket {
    private Long fee;
    public Long getFee() {
        return fee;
    }
}
```

관람객 객체 
``` java
public class Audience {
    private Bag bag;

    public Audience(Bag bag) {
        this.bag = bag;
    }
}
    public Bag getBag() {
        return bag;
    }
}
```

#### 관람객 클래스가 갖는 Bag 클래스

초대장을 받은 관람객 : 초대장 + 현금
초대장을 받지 않은 관람객 : 현금

``` java

public class Bag {
    private Long amount;
    private Invitation invitation;
    private Ticket ticket;

    public Bag(long amount) {
        this(null, amount);
    }

    public Bag(Invitation invitation, long amount) {
        this.invitation = invitation;
        this.amount = amount;
    }

    public boolean hasInvitation() {
        return invitation != null;
    }

    public boolean hasTicket() {
        return ticket != null;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    public void minusAmount(Long amount) {
        this.amount -= amount;
    }

    public void plusAmount(Long amount) {
        this.amount += amount;
    }
}
	
```

매표소 클래스 

``` java
public class TicketOffice {
    private Long amount;
    private List<Ticket> tickets = new ArrayList<>();

    public TicketOffice(Long amount, Ticket ... tickets) {
        this.amount = amount;
        this.tickets.addAll(Arrays.asList(tickets));
    }

    public Ticket getTicket() {
        return tickets.remove(0);
    }

    public void minusAmount(Long amount) {
        this.amount -= amount;
    }

    public void plusAmount(Long amount) {
        this.amount += amount;
    }
}
```

티켓 판매원 클래스
``` java
public class TicketSeller {
    private TicketOffice ticketOffice;

    public TicketSeller(TicketOffice ticketOffice) {
        this.ticketOffice = ticketOffice;
    }

    public TicketOffice getTicketOffice() {
        return ticketOffice;
    }
}


```

영화관 클래스
``` java
public class Theater {
    private TicketSeller ticketSeller;

    public Theater(TicketSeller ticketSeller) {
        this.ticketSeller = ticketSeller;
    }

    public void enter(Audience audience) {
        if (audience.getBag().hasInvitation()) {
            Ticket ticket = ticketSeller.getTicketOffice().getTicket();
            audience.getBag().setTicket(ticket);
        } else {
            Ticket ticket = ticketSeller.getTicketOffice().getTicket();
            audience.getBag().minusAmount(ticket.getFee());
            ticketSeller.getTicketOffice().plusAmount(ticket.getFee());
            audience.getBag().setTicket(ticket);
        }
    }
}
```
Enter 메소드 :  소극장은 먼저 관람객의 가방을 확인. 초대장이 있다면 판매원에게서 받은 티켓을 가방안에 넣어준다. 가방안에 티켓이 없다면 가방에서 티켓 금액만큼 차감한 후 매표소 금액을 증가. 


