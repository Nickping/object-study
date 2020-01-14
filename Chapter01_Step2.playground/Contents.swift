import UIKit

class Theater {
    private var ticketSeller: TicketSeller
    
    init(ticketSeller: TicketSeller) {
        self.ticketSeller = ticketSeller
    }
    
    func enter(audience: Audience) {
        ticketSeller.sellTo(audience: audience)
    }
}

class Audience {
    private var bag: Bag
    
    init(bag: Bag) {
        self.bag = bag
    }
    
    func buy(ticket: Ticket) -> Int {
        if bag.hasInvitation() {
            bag.minusAmount(amount: ticket.fee)
            bag.setTicket(ticket: ticket)
            return 0
        } else {
            bag.minusAmount(amount: ticket.fee)
            bag.setTicket(ticket: ticket)
            return ticket.fee
        }
    }
}

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

class Invitation {
    private(set) var when: Date?
}

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

class TicketSeller {
    private var ticketOffice: TicketOffice
    
    init(ticketOffice: TicketOffice) {
        self.ticketOffice = ticketOffice
    }
    
    func sellTo(audience: Audience) {
        guard let ticket = ticketOffice.getTicket() else { return }
        ticketOffice.plusAmount(amount: audience.buy(ticket: ticket))
    }
}

class Ticket {
    private(set) var fee: Int = 8500
}

