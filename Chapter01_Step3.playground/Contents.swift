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
        bag.hold(ticket: ticket)
    }
}

class Bag {
    private var amount: Int = 0
    private var invitation: Invitation?
    private var ticket: Ticket?
    
    convenience init(amount: Int) {
        self.init(amount: amount, invitation: nil)
    }
    
    init(amount: Int, invitation: Invitation?) {
        self.amount = amount
        self.invitation = invitation
    }
    
    func hold(ticket: Ticket) -> Int {
        if hasInvitation() {
            minusAmount(amount: ticket.fee)
            setTicket(ticket: ticket)
            return ticket.fee
        } else {
            minusAmount(amount: ticket.fee)
            setTicket(ticket: ticket)
            return ticket.fee
        }
    }
    
    private func hasTicket() -> Bool {
        return ticket != nil
    }
    
    private func hasInvitation() -> Bool {
        return invitation != nil
    }
    
    private func plusAmount(amount: Int) {
        self.amount += amount
    }
    
    private func minusAmount(amount: Int) {
        self.amount -= amount
    }
    
    private func setTicket(ticket: Ticket) {
        self.ticket = ticket
    }
    
}

class Invitation {
    private var when: Date?
}

class TicketOffice {
    private var amount: Int
    private var tickets: [Ticket]
    
    init(amount: Int, tickets: [Ticket]) {
        self.amount = amount
        self.tickets = tickets
    }
    
    func sellTicketTo(audience: Audience) {
        plusAmount(amount: audience.buy(ticket: getTicket()))
    }
    
    private func getTicket() -> Ticket {
        return tickets.removeFirst()
    }
    
    private func plusAmount(amount: Int) {
        self.amount += amount
    }
    
    private func minusAmount(amount: Int) {
        self.amount -= amount
    }
}

class TicketSeller {
    private var ticketOffice: TicketOffice
    
    init(ticketOffice: TicketOffice) {
        self.ticketOffice = ticketOffice
    }
    
    func sellTo(audience: Audience) {
        ticketOffice.sellTicketTo(audience: audience)
    }
}

class Ticket {
    private(set) var fee: Int = 8500
}

